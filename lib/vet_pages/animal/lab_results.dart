import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:intl/intl.dart';

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
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Silmek istediğinize emin misiniz?'),
          content:
              Text('Dosyayı kalıcı olarak silmek istediğinize emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('Vazgeç'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Sil'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
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
  }

  void viewLabResult(String fileName) {
    // Görüntüleme işlemleri burada gerçekleştirilecek
    print('Görüntüle: $fileName');
  }

  Future<void> _uploadFileWithCustomName(File file, String fileName) async {
    String currentDate = DateFormat('dd-MM-yy').format(DateTime.now());
    String newFileName = '$fileName - $currentDate.pdf'; // Yeni dosya adı

    Reference ref = _storage.ref('Animals/${widget.chipNumber}/$newFileName');
    UploadTask uploadTask = ref.putFile(file);

    await uploadTask.whenComplete(() async {
      setState(() {
        labResults.add(newFileName);
      });
      await FirebaseFirestore.instance
          .collection('Pets')
          .doc(widget.chipNumber)
          .update({
        'labResults': FieldValue.arrayUnion([newFileName])
      });
      _showSnackBar('Dosya yüklendi: $newFileName');
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
