import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'login_screen.dart';

class VetRegisterPage extends StatefulWidget {
  @override
  _VetRegisterPageState createState() => _VetRegisterPageState();
}

class _VetRegisterPageState extends State<VetRegisterPage> {
  File? _selectedImage;
  File? _secondSelectedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _namesurnameController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  bool _checkValue1 = false;
  bool _checkValue2 = false;
  String bio = '';

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickSecondImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _secondSelectedImage = File(pickedImage.path);
      });
    }
  }

  void _navigateToAnotherPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Bilgilerim",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'E-posta adresi boş olamaz';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _namesurnameController,
                        decoration: InputDecoration(
                          labelText: 'Ad Soyad',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ad Soyad boş olamaz';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _universityController,
                        decoration: InputDecoration(
                          labelText: 'Üniversiteniz',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Üniversite boş olamaz';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Parola',
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Parola boş olamaz';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Parola Tekrar',
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Parola tekrarı boş olamaz';
                          } else if (value != _passwordController.text) {
                            return 'Parolalar eşleşmiyor';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Telefon Numarası',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _speciesController,
                        decoration: const InputDecoration(
                          labelText:
                              'Baktığınız Türler? Örnek: Kedi, Balık, Sincap...',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Baktığınız türleri boş bırakamazsınız';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('E-devlet Mezuniyet Belgesi Yükle'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickSecondImage,
                      child: Text('Profil Resmi Yükle'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _checkValue1,
                          onChanged: (value) {
                            setState(() {
                              _checkValue1 = value!;
                            });
                          },
                        ),
                        Text('Tedavi İçin Evlere Giderim'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _checkValue2,
                          onChanged: (value) {
                            setState(() {
                              _checkValue2 = value!;
                            });
                          },
                        ),
                        Text('Acil Hasta Bakarım'),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 345,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _passwordController.text ==
                                  _confirmPasswordController.text &&
                              _selectedImage != null &&
                              _secondSelectedImage != null &&
                              _speciesController.text.isNotEmpty) {
                            _register();
                          } else {
                            var snackBar = SnackBar(
                              content: Text(
                                  'Lütfen tüm alanları doldurun ve resimleri yükleyin'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text(
                          'Kayıt Ol',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _register() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Kullanıcının Firestore'daki doküman yolunu oluşturun
      String uid = userCredential.user!.uid;
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('Veterinarians').doc(uid);

      // Firestore dokümanını oluşturun
      await userDocRef.set({
        'email': userCredential.user!.email,
        'isVet': 'false',
        'name': _namesurnameController.text,
        'university': _universityController.text,
        'species': _speciesController.text,
        'phone number': _phoneNumberController.text,
        'bio': bio,
        'evde bakım': _checkValue1,
        'acil bakım': _checkValue2,
      });

      // Resmi Firebase Storage'a yükle
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('Veterinarians/$uid/profile_image.jpg');
      await storageRef.putFile(_selectedImage!);

      // Profil resmini Firebase Storage'a yükle
      final secondStorageRef = FirebaseStorage.instance
          .ref()
          .child('profile_picture/$uid/profile_picture.jpg');
      await secondStorageRef.putFile(_secondSelectedImage!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Kayıt başarılı! Moderatörler hesabınızı onayladıktan sonra giriş yapabilirsiniz.'),
        ),
      );

      await Future.delayed(Duration(seconds: 2));

      _navigateToAnotherPage(); // Giriş yapma sayfasına yönlendir
    } catch (e) {
      String errorMessage = 'Bir hata oluştu. Kayıt işlemi başarısız oldu.';
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          errorMessage = 'E-posta adresi zaten kullanımda.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'Şifre en az 6 karakterden oluşmalıdır.';
        }
      }
      var snackBar = SnackBar(content: Text(errorMessage));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
