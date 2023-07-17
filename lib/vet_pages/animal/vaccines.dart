import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

class Vaccines extends StatefulWidget {
  final String chipNumber;

  Vaccines({required this.chipNumber});

  @override
  _VaccinesState createState() => _VaccinesState();
}

class _VaccinesState extends State<Vaccines> {
  Map<String, Timestamp> vaccines = {};
  TextEditingController vaccineNameController = TextEditingController();
  DateTime? selectedDate;
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    getVaccines();
  }

  void getVaccines() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Pets')
        .doc(widget.chipNumber)
        .get();

    if (documentSnapshot.exists) {
      setState(() {
        final data = documentSnapshot.data() as Map<String, dynamic>?;
        final vaccinesData = data?['vaccines'] as Map<String, dynamic>?;

        if (vaccinesData != null) {
          vaccinesData.forEach((key, value) {
            vaccines[key] = value as Timestamp;
          });
        }
      });
    }
  }

  void addVaccine() {
    String vaccineName = vaccineNameController.text.trim();

    if (vaccineName.isNotEmpty && selectedDate != null) {
      Timestamp vaccineDate = Timestamp.fromDate(selectedDate!);

      setState(() {
        vaccines[vaccineName] = vaccineDate;
      });

      FirebaseFirestore.instance
          .collection('Pets')
          .doc(widget.chipNumber)
          .update({
        'vaccines': vaccines,
      });

      vaccineNameController.clear();
      selectedDate = null;
    }
  }

  void deleteVaccine(String vaccineName) {
    setState(() {
      vaccines.remove(vaccineName);
    });

    FirebaseFirestore.instance
        .collection('Pets')
        .doc(widget.chipNumber)
        .update({
      'vaccines': vaccines,
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        focusedDay = selectedDate!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aşılar'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hayvan Çip Numarası: ${widget.chipNumber}',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 20),
              Text(
                'Takvim',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TableCalendar(
                locale: 'tr_TR',
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: focusedDay,
                calendarFormat: calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedDate = selectedDay;
                    this.focusedDay = focusedDay;
                  });
                },
                eventLoader: (day) {
                  List<Map<String, dynamic>> events = [];
                  vaccines.forEach((key, value) {
                    if (value.toDate().year == day.year &&
                        value.toDate().month == day.month &&
                        value.toDate().day == day.day) {
                      events.add({'name': key, 'date': value.toDate()});
                    }
                  });
                  return events;
                },
                calendarBuilders: CalendarBuilders(
                  todayBuilder: (context, date, _) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = date;
                          focusedDay = date;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedDate == date
                              ? Colors.blue
                              : Colors.transparent,
                        ),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: selectedDate == date
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(
                'Gelecek Aşı Tarihleri:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: vaccines.length,
                itemBuilder: (context, index) {
                  final vaccineName = vaccines.keys.toList()[index];
                  final vaccineDate = vaccines[vaccineName]!.toDate();
                  final formattedDate =
                      "${vaccineDate.day}/${vaccineDate.month}/${vaccineDate.year}";

                  return ListTile(
                    title: Text('$vaccineName - $formattedDate'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteVaccine(vaccineName),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Yeni Aşı Ekle:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: vaccineNameController,
                decoration: InputDecoration(
                  labelText: 'Aşı Adı',
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Aşının Tarihi',
                    hintText: 'Tarih Seçin',
                  ),
                  child: Text(selectedDate != null
                      ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                      : 'Tarih Seçilmedi'),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: addVaccine,
                child: Text('Aşı Ekle'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
