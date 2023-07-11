import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petcare/login_signup/login_screen.dart';
import 'package:petcare/tasarim_UI/tema.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _emailController = TextEditingController();

  void _resetPassword() async {
    String email = _emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Şifre sıfırlama e-postası gönderildiğinde yapılacak işlemler
      _navigateToAnotherPage();
    } catch (error) {
      // Hata durumunda yapılacak işlemler
     var snackBar = SnackBar(content: Text('İşlem Gerçekleştirilemedi !'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  void _navigateToAnotherPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Şifremi Unuttum'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-posta',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _resetPassword();
                    
                  },
                  child: Text('Şifreyi Sıfırla'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
