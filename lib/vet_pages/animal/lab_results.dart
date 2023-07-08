import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class LabResults extends StatefulWidget {
  final String chipNumber;

  LabResults({required this.chipNumber});

  @override
  _LabResultsState createState() => _LabResultsState();
}

class _LabResultsState extends State<LabResults> {
  final TextEditingController _fileNameController = TextEditingController();
  List<String> labResults = [];

  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    getLabResults();
  }

  void getLabResults() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Pets')
        .doc(widget.chipNumber)
        .get();

    if (documentSnapshot.exists) {
      setState(() {
        final data = documentSnapshot.data() as Map<String, dynamic>?;
        labResults = List<String>.from(data?['labResults'] ?? []);
      });
    }
  }

  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      _showSaveDialog(file);
    } else {
      // Kullanıcı dosya seçimini iptal etti veya herhangi bir dosya seçmedi
    }
  }

  void removeLabResult(String fileName) async {
    setState(() {
      labResults.remove(fileName);
    });

    FirebaseFirestore.instance
        .collection('Pets')
        .doc(widget.chipNumber)
        .update({
      'labResults': FieldValue.arrayRemove([fileName])
    });

    Reference ref = _storage.ref('Animals/${widget.chipNumber}/$fileName');
    await ref.delete();

    _showSnackBar('Dosya silindi: $fileName');
  }

  void viewLabResult(String fileName) async {
    Reference ref = _storage.ref('Animals/${widget.chipNumber}/$fileName');
    String url = await ref.getDownloadURL();

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Dosya açılamadı: $url';
    }
  }

  Future<void> _uploadFileWithCustomName(File file, String fileName) async {
    Reference ref = _storage.ref('Animals/${widget.chipNumber}/$fileName');
    UploadTask uploadTask = ref.putFile(file);

    await uploadTask.whenComplete(() {
      setState(() {
        labResults.add(fileName);
      });
      FirebaseFirestore.instance
          .collection('Pets')
          .doc(widget.chipNumber)
          .update({
        'labResults': FieldValue.arrayUnion([fileName])
      });
      _showSnackBar('Dosya yüklendi: $fileName');
    }).catchError((onError) {
      print(onError);
    });
  }

  void _showSaveDialog(File file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Dosya Adı'),
        content: TextField(
          controller: _fileNameController,
          decoration: InputDecoration(hintText: 'Dosya adını girin'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String fileName = _fileNameController.text.trim();
              if (fileName.isNotEmpty) {
                Navigator.pop(context);
                _uploadFileWithCustomName(file, fileName);
              }
            },
            child: Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab Sonuçları'),
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
            ElevatedButton(
              onPressed: uploadFile,
              child: Text('PDF Yükle'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: labResults.length,
                itemBuilder: (context, index) {
                  final fileName = labResults[index];
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () => viewLabResult(fileName),
                    ),
                    title: Text(fileName),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => removeLabResult(fileName),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
