import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petcare/login_signup/password_reset_screen.dart';
import 'package:petcare/login_signup/signup_page.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'package:petcare/user_profile_pages/user_profile.dart';
import '../vet_pages/vet._main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginSuccess = false;
  late DocumentSnapshot userSnapshot;
  late DocumentSnapshot vetSnapshot;
   Stream<User?> get authStateChanges => _auth.authStateChanges();


  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      String uid = userCredential.user!.uid;
      

      // Firestore'da users koleksiyonundan kullanıcıyı sorgula
      userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      // Firestore'da vet koleksiyonundan kullanıcıyı sorgula
      vetSnapshot =
          await FirebaseFirestore.instance.collection('Veterinarians').doc(uid).get();

      if (userSnapshot.exists && userSnapshot.get('isUser') == 'true') {
        print('Giriş yapıldı, User için izin verildi.');
        setState(() {
          _isLoginSuccess = true;
        });
      } else if (vetSnapshot.exists && vetSnapshot.get('isVet') == 'true') {
        print('Giriş yapıldı, Vet için izin verildi.');
        setState(() {
          _isLoginSuccess = true;
        });
      } else {
        print('Giriş reddedildi, izin verilmedi.');
        // İzin verilmediyse uygun işlemi yapabilirsiniz (örneğin hata mesajı göstermek)
      }
    } catch (e) {
      print('Hata: $e');
    }
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: Scaffold(
       
        body: _isLoginSuccess
            ? _buildContent()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-posta',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Şifre',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _signInWithEmailAndPassword,
                      child: Text('Giriş Yap'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: ((context) {
                                return PasswordResetPage();
                              })),
                            );
                          },
                          child: Text("Şifremi Unuttum"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hala üye değil misiniz ?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: ((context) {
                                return SignUpScreen();
                              })),
                            );
                          },
                          child: Text("Hemen üye ol"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildContent() {
  if (_isLoginSuccess) {
    if (userSnapshot.exists && userSnapshot.get('isUser') == 'true') {
      return UserProfile();
    } else if (vetSnapshot.exists && vetSnapshot.get('isVet') == 'true') {
      return ProfilePage();
    }
  }

  return Center(
    child: Text('Giriş Başarılı!'),
  );
}
}
