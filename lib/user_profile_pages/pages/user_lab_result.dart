import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PetDocumentsPage extends StatefulWidget {
  @override
  _PetDocumentsPageState createState() => _PetDocumentsPageState();
}

class _PetDocumentsPageState extends State<PetDocumentsPage> {
  String? _selectedPet;
  List<String> _pets = [];
  List<String> _documentPaths = [];

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

  Future<void> _fetchPetDocuments(String chipId) async {
    final storage = FirebaseStorage.instance;
    final petsFolderRef = storage.ref().child('Animals/$chipId');

    final ListResult result = await petsFolderRef.listAll();

    final List<String> documentPaths = result.items.map((Reference ref) {
      return ref.fullPath;
    }).toList();

    setState(() {
      _documentPaths = documentPaths;
    });
  }

  Future<void> _downloadAndOpenPDF(String path) async {
    final dir = await getTemporaryDirectory();
    final fileName = path.split('/').last;
    final filePath = '${dir.path}/$fileName';

    final ref = FirebaseStorage.instance.ref().child(path);
    final file = File(filePath);
    await ref.writeToFile(file);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFView(
          filePath: file.path,
          onRender: (_pages) {
            setState(() {
              // PDF dosyası renderlandığında, yazı boyutunu ayarlamak için setState kullanılıyor
            });
          },
        ),
      ),
    );
  }

  Widget _buildDocumentCard(String path) {
    final fileName = path.split('/').last;

    return Card(
      child: InkWell(
        onTap: () {
          if (path.endsWith('.pdf')) {
            _downloadAndOpenPDF(path);
          }
        },
        child: ListTile(
          title: Text(
            fileName,
            style: TextStyle(
              fontSize: 18.0, // Yazı boyutunu istediğiniz gibi ayarlayın
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tahlillerim'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedPet,
            hint: Text("Evcil Hayvan ID Seç") ,
            items: _pets.map((String pet) {
              return DropdownMenuItem<String>(
                value: pet,
                child: Text(pet),
              );
            }).toList(),
            onChanged: (String? selectedPet) {
              setState(() {
                _selectedPet = selectedPet;
                if (selectedPet != null) {
                  _fetchPetDocuments(selectedPet);
                } else {
                  _documentPaths = [];
                }
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _documentPaths.length,
              itemBuilder: (context, index) {
                final path = _documentPaths[index];

                return _buildDocumentCard(path);
              },
            ),
          ),
        ],
      ),
    );
  }
}










