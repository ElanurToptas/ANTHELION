import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiseasesPage extends StatefulWidget {
  @override
  _DiseasesPageState createState() => _DiseasesPageState();
}

class _DiseasesPageState extends State<DiseasesPage> {
  String? _selectedPet;
  List<String> _pets = [];
  List<String> _diseases = [];

  @override
  void initState() {
    super.initState();
    _fetchUserPets();
  }

  Future<void> _fetchUserPets() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    final petsList = userDoc.get('pets') as List<dynamic>;

    setState(() {
      _pets = petsList.map((pet) => pet['chipId'].toString()).toList();
    });
  }

  Future<void> _fetchPetDiseases() async {
    if (_selectedPet != null) {
      final petId = _selectedPet!;
      final petDoc = await FirebaseFirestore.instance.collection('Pets').doc(petId).get();

      if (petDoc.exists) {
        final petData = petDoc.data();
        if (petData != null) {
          final diseases = petData['diseases'] as List<dynamic>;
          setState(() {
            _diseases = diseases.map((disease) => disease.toString()).toList();
          });
        }
      } else {
        print('Seçilen hayvana ait veri bulunamadı.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(224, 234, 234, 234),
      appBar: AppBar(
        title: Text('Hastalıklar Detay'),
      ),
      body: SingleChildScrollView(
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
                  'Hastalıklar:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _diseases.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_diseases[index]),
                  );
                },
              ),
              // Harita bileşeni buraya eklenebilir
            ],
          ),
        ),
      ),
    );
  }
}
