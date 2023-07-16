import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petcare/tasarim_UI/tema.dart';

class DiseasesPage extends StatefulWidget {
  @override
  _DiseasesPageState createState() => _DiseasesPageState();
}

class _DiseasesPageState extends State<DiseasesPage> {
  String? _selectedPet;
  List<String> _pets = [];
  List<Map<String, dynamic>> _diseases = [];

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

  Future<void> _fetchPetDiseases() async {
    if (_selectedPet != null) {
      final petId = _selectedPet!;
      final petDoc =
          await FirebaseFirestore.instance.collection('Pets').doc(petId).get();

      if (petDoc.exists) {
        final petData = petDoc.data();
        if (petData != null) {
          final diseases = petData['diseases'] as List<dynamic>;
          setState(() {
            _diseases = List<Map<String, dynamic>>.from(diseases);
          });
        }
      } else {
        print('Seçilen hayvana ait veri bulunamadı.');
      }
    }
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
    return MaterialApp(
      theme: theme(),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Hastalık Detayı'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/ArkaPlan/Arka Plan.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: _selectedPet,
                    hint: Text('Evcil Hayvan ID Seçin'),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedPet = value;
                        _fetchPetDiseases();
                      });
                    },
                    items: _pets.map<DropdownMenuItem<String>>((String pet) {
                      return DropdownMenuItem<String>(
                        value: pet,
                        child: Text(pet),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  if (_diseases.isNotEmpty)
                    Text(
                      'Hastalık Tanıları:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _diseases.length,
                    itemBuilder: (context, index) {
                      final disease = _diseases[index];
                      return ListTile(
                        title: Text(disease['name']),
                        subtitle: Text(disease['date']),
                        onTap: () => showDiseaseDetails(disease),
                      );
                    },
                  ),
                  // Harita bileşeni buraya eklenebilir
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
