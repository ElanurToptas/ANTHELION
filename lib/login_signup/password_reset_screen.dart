import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Şifre Sıfırlama'),
          content: Text('Şifre sıfırlama bağlantısı e-posta adresinize gönderildi.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    } catch (error) {
      // Hata durumunda yapılacak işlemler
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Hata'),
          content: Text('Şifre sıfırlama sırasında bir hata oluştu.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: _resetPassword,
                child: Text('Şifreyi Sıfırla'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
