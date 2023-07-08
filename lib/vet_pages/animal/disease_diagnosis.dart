import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseDiagnosisPage extends StatefulWidget {
  final String chipNumber;

  DiseaseDiagnosisPage({required this.chipNumber});

  @override
  _DiseaseDiagnosisPageState createState() => _DiseaseDiagnosisPageState();
}

class _DiseaseDiagnosisPageState extends State<DiseaseDiagnosisPage> {
  final TextEditingController _diseaseController = TextEditingController();
  List<String> diseases = [];

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
        final data = documentSnapshot.data()
            as Map<String, dynamic>?; // Dönüşümü gerçekleştirin
        diseases = List<String>.from(data?['diseases'] ?? []);
      });
    }
  }

  void addDisease() {
    String newDisease = _diseaseController.text.trim();
    if (newDisease.isNotEmpty) {
      setState(() {
        diseases.add(newDisease);
      });

      FirebaseFirestore.instance
          .collection('Pets')
          .doc(widget.chipNumber)
          .update({
        'diseases': FieldValue.arrayUnion([newDisease])
      });

      _diseaseController.clear();
    }
  }

  void removeDisease(String disease) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hastalığı Sil'),
          content: Text('Bu hastalığı silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Pencereyi kapat
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

                Navigator.of(context).pop(); // Pencereyi kapat
              },
              child: Text('Sil'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _diseaseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hastalık Teşhisi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Seçilen Hayvanın Çip Numarası: ${widget.chipNumber}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _diseaseController,
              decoration: InputDecoration(
                labelText: 'Hastalık',
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
                  title: Text(disease),
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
    );
  }
}
