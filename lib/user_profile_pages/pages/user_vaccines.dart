import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:petcare/user_profile_pages/pages/utils_calender.dart';


class YourPage extends StatefulWidget {
  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  String? _selectedPet;
  List<String> _pets = [];
  List<String> _vaccines = [];
  

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

  Future<void> _fetchPetVaccines() async {
    if (_selectedPet != null) {
      final petId = _selectedPet!;
      final petDoc = await FirebaseFirestore.instance.collection('Pets').doc(petId).get();

      if (petDoc.exists) {
        final petData = petDoc.data();
        if (petData != null) {
          final vaccines = petData['vaccines'] as List<dynamic>;
          setState(() {
            _vaccines = vaccines.map((vaccine) => vaccine.toString()).toList();
          });
        }
      } else {
        print('Seçilen hayvana ait veri bulunamadı.');
      }
    }
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromARGB(224, 234, 234, 234),
      appBar: AppBar(
        title: Text('Aşılar ve Aşı Takvimi'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: _selectedPet,
                hint: Text('Select a pet'),
                onChanged: (String? value) {
                  setState(() {
                    _selectedPet = value;
                    _fetchPetVaccines();
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
              if (_vaccines.isNotEmpty)
                Text(
                  'Vaccines:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _vaccines.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_vaccines[index]),
                  );
                },
              ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyHeatMap(),
                  ],
                )
            ],
 
          ),
        ),
      ),
    );
  }
}

















