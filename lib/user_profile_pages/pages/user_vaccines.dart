import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';

class YourPage extends StatefulWidget {
  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  String? _selectedPet;
  List<String> _pets = [];
  Map<String, Timestamp> _vaccines = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _fetchUserPets();
  }

  Future<void> _fetchUserPets() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    final petsList = userDoc.get('pets') as List<dynamic>;

    setState(() {
      _pets = petsList.map((pet) => pet['chipId'].toString()).toList();
    });
  }

  Future<void> _fetchPetVaccines() async {
    if (_selectedPet != null) {
      final petId = _selectedPet!;
      final petDoc =
          await FirebaseFirestore.instance.collection('Pets').doc(petId).get();

      if (petDoc.exists) {
        final petData = petDoc.data();
        if (petData != null) {
          final vaccines = petData['vaccines'] as Map<String, dynamic>;
          setState(() {
            _vaccines =
                vaccines.map((key, value) => MapEntry(key, value as Timestamp));
          });
        }
      } else {
        print('Seçilen hayvana ait veri bulunamadı.');
      }
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Page'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedPet,
            items: _pets.map((pet) {
              return DropdownMenuItem<String>(
                value: pet,
                child: Text(pet),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedPet = value;
                _fetchPetVaccines();
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            'Gelecek Aşı Tarihleri:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _vaccines.length,
              itemBuilder: (context, index) {
                final vaccineName = _vaccines.keys.toList()[index];
                final vaccineDate = _vaccines[vaccineName]!.toDate();
                final formattedDate =
                    "${vaccineDate.day}/${vaccineDate.month}/${vaccineDate.year}";

                return ListTile(
                  title: Text('$vaccineName - $formattedDate'),
                );
              },
            ),
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
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
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
            onDaySelected: _onDaySelected,
            eventLoader: (day) {
              List<Map<String, dynamic>> events = [];
              _vaccines.forEach((key, value) {
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
                      _selectedDay = date;
                      _focusedDay = date;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedDay == date
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color:
                            _selectedDay == date ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
