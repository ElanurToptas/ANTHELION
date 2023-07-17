import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DiseaseDiagnosisPage extends StatefulWidget {
  final String chipNumber;

  DiseaseDiagnosisPage({required this.chipNumber});

  @override
  _DiseaseDiagnosisPageState createState() => _DiseaseDiagnosisPageState();
}

class _DiseaseDiagnosisPageState extends State<DiseaseDiagnosisPage> {
  final TextEditingController _diseaseNameController = TextEditingController();
  final TextEditingController _diseaseDescriptionController =
      TextEditingController();
  List<Map<String, dynamic>> diseases = [];

  @override
  void initState() {
    super.initState();
    getDiseases();
  }

  void getDiseases() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Pets')
        .doc(widget.chipNumber)
        .get();

    if (documentSnapshot.exists) {
      setState(() {
        final data = documentSnapshot.data() as Map<String, dynamic>?;

        diseases = List<Map<String, dynamic>>.from(data?['diseases'] ?? []);
      });
    }
  }

  void addDisease() {
    String diseaseName = _diseaseNameController.text.trim();
    String diseaseDescription = _diseaseDescriptionController.text.trim();

    if (diseaseName.isNotEmpty && diseaseDescription.isNotEmpty) {
      String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      Map<String, dynamic> newDisease = {
        'name': diseaseName,
        'date': currentDate,
        'description': diseaseDescription,
      };

      setState(() {
        diseases.add(newDisease);
      });

      FirebaseFirestore.instance
          .collection('Pets')
          .doc(widget.chipNumber)
          .update({
        'diseases': FieldValue.arrayUnion([newDisease])
      });

      _diseaseNameController.clear();
      _diseaseDescriptionController.clear();
    }
  }

  void removeDisease(Map<String, dynamic> disease) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hastalığı Sil'),
          content: Text('Bu hastalığı silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  diseases.remove(disease);
                });

                FirebaseFirestore.instance
                    .collection('Pets')
                    .doc(widget.chipNumber)
                    .update({
                  'diseases': FieldValue.arrayRemove([disease])
                });

                Navigator.of(context).pop();
              },
              child: Text('Sil'),
            ),
          ],
        );
      },
    );
  }

  void showDiseaseDetails(Map<String, dynamic> disease) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(disease['name']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tarih: ${disease['date']}'),
              SizedBox(height: 10),
              Text('Açıklama: ${disease['description']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    diseases.sort((a, b) {
      DateTime dateA = DateFormat('dd/MM/yyyy').parse(a['date']);
      DateTime dateB = DateFormat('dd/MM/yyyy').parse(b['date']);
      return dateB.compareTo(dateA);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Hastalık Teşhisi'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Hayvan Çip Numarası: ${widget.chipNumber}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _diseaseNameController,
                decoration: InputDecoration(
                  labelText: 'Hastalık Adı',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _diseaseDescriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Hastalık Açıklaması',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 60.0, horizontal: 5),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addDisease,
                child: Text('Hastalık Ekle'),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: diseases.length,
                itemBuilder: (context, index) {
                  final disease = diseases[index];
                  return ListTile(
                    title: Text(disease['name']),
                    subtitle: Text(disease['date']),
                    onTap: () => showDiseaseDetails(disease),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => removeDisease(disease),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
