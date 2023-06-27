import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ButtonStyles {
  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 111, 132, 255),
    textStyle: TextStyle(fontSize: 18),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
    minimumSize: Size(80, 80),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

class EditVetProfile extends StatefulWidget {
  @override
  _EditVetProfileState createState() => _EditVetProfileState();
}

class _EditVetProfileState extends State<EditVetProfile> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final imageCropper = ImageCropper();
      final croppedImage = await imageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 70,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
      );
      if (croppedImage != null) {
        setState(() {
          _image = File(croppedImage.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(49, 123, 93, 255),
        title: Text('Veteriner Profili Düzenle'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyles.elevatedButtonStyle,
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: Text('Profil Fotoğrafını Değiştir'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyles.elevatedButtonStyle,
                    onPressed: () {},
                    child: Text('Profili Bilgilerimi Düzenle'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyles.elevatedButtonStyle,
                    onPressed: () {},
                    child: Text('Biyografimi Düzenle'),
                  ),
                  SizedBox(height: 16),
                  if (_image != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(_image!),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
