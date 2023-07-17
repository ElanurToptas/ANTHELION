import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'package:petcare/main.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _uid = '';
  String _currentName = '';
  String _currentEmail = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _uid = user.uid;
        _currentEmail = user.email ?? '';
      });

      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('Users').doc(_uid).get();

      if (snapshot.exists) {
        setState(() {
          _currentName = snapshot.get('name');
          _nameController.text = _currentName;
          _emailController.text = _currentEmail;
        });
      }
    }
  }

  Future<void> _changeUserName() async {
    String newName = _nameController.text;
    try {
      await _firestore.collection('Users').doc(_uid).update({'name': newName});
      setState(() {
        _currentName = newName;
      });
      _showSuccessMessage('Kullanıcı adı güncellendi');
    } catch (error) {
      _showErrorMessage('Kullanıcı adını güncellerken bir hata oluştu');
    }
  }

  Future<void> _changeUserEmail() async {
    String newEmail = _emailController.text;
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        await _firestore
            .collection('Users')
            .doc(_uid)
            .update({'email': newEmail});
        setState(() {
          _currentEmail = newEmail;
        });
        _showSuccessMessage('E-posta adresi güncellendi');
      }
    } catch (error) {
      _showErrorMessage('E-posta adresini güncellerken bir hata oluştu');
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
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
            title: Text('Profil Düzenle'),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/ArkaPlan/Arka Plan.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Kullanıcı Adı:',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    controller: _nameController,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'E-posta Adresi:',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    controller: _emailController,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Mevcut Kullanıcı Adı: $_currentName',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Mevcut E-posta Adresi: $_currentEmail',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: 350,
                    child: ElevatedButton(
                      onPressed: _changeUserName,
                      child: Text(
                        'Kullanıcı Adını Güncelle',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  SizedBox(
                    width: 350,
                    child: ElevatedButton(
                        onPressed: _changeUserEmail,
                        child: Text(
                          'E-posta Adresini Güncelle',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  SizedBox(height: 8.0),
                  SizedBox(
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signOut().then((value) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          });
                          // Oturum başarıyla kapatıldıktan sonra yapılacak işlemler
                          // Örneğin, kullanıcıyı başka bir sayfaya yönlendirebilirsiniz.
                        } catch (e) {
                          // Oturum kapatma işlemi başarısız oldu
                          print('Oturum kapatma hatası: $e');
                        }
                      },
                      child: Text('Çıkış Yap', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
