import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class Vaccines extends StatefulWidget {
  final String chipNumber;

  Vaccines({required this.chipNumber});

  @override
  _VaccinesState createState() => _VaccinesState();
}

class _VaccinesState extends State<Vaccines> {
  Map<String, Timestamp> vaccines = {};
  Map<DateTime, int> datasets = {};
  DateTime selectedDate = DateTime.now();
  TextEditingController vaccineNameController = TextEditingController();
  TextEditingController vaccineDurationController = TextEditingController();

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
          vaccines = Map<String, Timestamp>.from(vaccinesData);
        }

        datasets = {};

        vaccines.forEach((vaccineName, timestamp) {
          DateTime date = timestamp.toDate();
          datasets[date] = datasets[date] != null ? datasets[date]! + 1 : 1;
        });
      });
    }
  }

  void addVaccine() {
    String vaccineName = vaccineNameController.text.trim();
    String vaccineDuration = vaccineDurationController.text.trim();

    if (vaccineName.isNotEmpty && vaccineDuration.isNotEmpty) {
      DateTime currentDate = DateTime.now();
      DateTime expirationDate =
          currentDate.add(Duration(days: int.parse(vaccineDuration)));

      Map<String, dynamic> vaccineInfo = {
        'name': vaccineName,
        'date': Timestamp.fromDate(expirationDate),
      };

      setState(() {
        vaccines[vaccineName] = Timestamp.fromDate(expirationDate);
        datasets[expirationDate] = datasets[expirationDate] != null
            ? datasets[expirationDate]! + 1
            : 1;
      });

      FirebaseFirestore.instance
          .collection('Pets')
          .doc(widget.chipNumber)
          .update({
        'vaccines': vaccines,
      });

      vaccineNameController.clear();
      vaccineDurationController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccines'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Seçilen Hayvanın Çip Numarası: ${widget.chipNumber}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                'Aşı Bilgileri:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: vaccines.length,
                itemBuilder: (context, index) {
                  final vaccineName = vaccines.keys.toList()[index];
                  final vaccineDate = vaccines[vaccineName]!.toDate();
                  return ListTile(
                    title: Text('$vaccineName - $vaccineDate'),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Heatmap Calendar:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 400,
                child: HeatMap(
                  datasets: datasets,
                  startDate: DateTime.now(),
                  endDate: DateTime.now().add(Duration(days: 40)),
                  colorMode: ColorMode.opacity,
                  size: 40,
                  textColor: const Color.fromARGB(255, 255, 64, 64),
                  showText: false,
                  scrollable: true,
                  colorsets: {
                    1: Colors.red,
                    3: Colors.orange,
                    5: Colors.yellow,
                    7: Colors.green,
                    9: Colors.blue,
                    11: Colors.indigo,
                    13: Colors.purple,
                  },
                  onClick: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(value.toString())));
                  },
                ),
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
              TextField(
                controller: vaccineDurationController,
                decoration: InputDecoration(
                  labelText: 'Geçerlilik Süresi (gün)',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: addVaccine,
                child: Text('Aşı Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
