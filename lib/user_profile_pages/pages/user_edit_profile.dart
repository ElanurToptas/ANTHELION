import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        await _firestore.collection('Users').doc(_uid).update({'email': newEmail});
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
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Color.fromARGB(212, 255, 253, 253),
      appBar: AppBar(
        title: Text('Profil Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          children: [
            Text(
              'Kullanıcı Adı:',
              style: TextStyle(fontSize: 16.0),
            ),
            TextFormField(
              controller: _nameController,
            ),
            SizedBox(height: 16.0),
            Text(
              'E-posta Adresi:',
              style: TextStyle(fontSize: 16.0),
            ),
            TextFormField(
              controller: _emailController,
            ),
            SizedBox(height: 16.0),
            
            Text(
              'Mevcut Kullanıcı Adı: $_currentName',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Mevcut E-posta Adresi: $_currentEmail',
              style: TextStyle(fontSize: 16.0),
            ),
             SizedBox(height: 16.0),
            SizedBox(width: 250,
              child: ElevatedButton(style:ElevatedButton.styleFrom(
                           backgroundColor: Colors.deepPurple,),
                onPressed: _changeUserName,
                child: Text('Kullanıcı Adını Güncelle'),
              ),
            ),
            SizedBox(height: 8.0),
            SizedBox(width: 250,
              child: ElevatedButton(style:ElevatedButton.styleFrom(
                           backgroundColor: Colors.deepPurple,),
                onPressed: _changeUserEmail,
                child: Text('E-posta Adresini Güncelle'),
              ),
            ),
            SizedBox(height: 8.0),
          
             
            SizedBox(width: 250, 
              child: ElevatedButton(style:ElevatedButton.styleFrom(
                           backgroundColor: Colors.deepPurple,),
                onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  // Oturum başarıyla kapatıldıktan sonra yapılacak işlemler
                  // Örneğin, kullanıcıyı başka bir sayfaya yönlendirebilirsiniz.
                } catch (e) {
                  // Oturum kapatma işlemi başarısız oldu
                  print('Oturum kapatma hatası: $e');
                }
              },
                child: Text('Çıkış Yap'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
