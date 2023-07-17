import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petcare/login_signup/password_reset_screen.dart';
import 'package:petcare/login_signup/signup_page.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'package:petcare/user_profile_pages/user_profile.dart';
import 'package:petcare/vet_pages/vet._main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late User? _user;
  bool _isLoginSuccess = false;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _checkUserType(_user!.uid);
    }
  }

  void _checkUserType(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      DocumentSnapshot vetSnapshot = await FirebaseFirestore.instance
          .collection('Veterinarians')
          .doc(uid)
          .get();
      if (mounted) {
        if (userSnapshot.exists && userSnapshot.get('isUser') == 'true') {
          setState(() {
            _isLoginSuccess = true;
          });
        } else if (vetSnapshot.exists && vetSnapshot.get('isVet') == 'true') {
          setState(() {
            _isLoginSuccess = true;
          });
        }
      }
    } catch (e) {
      // Handle any potential errors
      print('Error: $e');
    }
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      _checkUserType(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Geçersiz e-posta veya şifre';
      if (e.code == 'invalid-email') {
        errorMessage = 'Geçersiz e-posta adresi!';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Geçersiz e-posta veya şifre!';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/ArkaPlan/Arka Plan.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: _isLoginSuccess
                ? _buildContent()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/Kullanıcı/uye.png',
                        ),
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
                          child: Text(
                            'Giriş Yap',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
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
                              child: Text(
                                "Şifremi Unuttum!",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Hala üye değil misiniz ?",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: ((context) {
                                    return SignUpScreen();
                                  })),
                                );
                              },
                              child: Text(
                                "Hemen üye ol!",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoginSuccess) {
      if (_user != null) {
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(_user!.uid)
              .get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show a loading indicator while waiting for the snapshot
            }
            if (userSnapshot.hasError) {
              return Text(
                  'Error: ${userSnapshot.error}'); // Show an error message if snapshot retrieval fails
            }
            if (userSnapshot.data != null &&
                userSnapshot.data!.exists &&
                userSnapshot.data!.get('isUser') == 'true') {
              return UserProfile();
            } else {
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Veterinarians')
                    .doc(_user!.uid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> vetSnapshot) {
                  if (vetSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (vetSnapshot.hasError) {
                    return Text('Error: ${vetSnapshot.error}');
                  }
                  if (vetSnapshot.data != null &&
                      vetSnapshot.data!.exists &&
                      vetSnapshot.data!.get('isVet') == 'true') {
                    return ProfilePage();
                  } else {
                    return Center(
                      child: Text('Giriş Başarılı!'),
                    );
                  }
                },
              );
            }
          },
        );
      }
    }

    return Center(
      child: Text('Giriş Başarılı!'),
    );
  }
}
