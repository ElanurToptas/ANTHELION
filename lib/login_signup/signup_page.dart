import 'package:flutter/material.dart';
import 'package:petcare/login_signup/users_signup.dart';
import 'package:petcare/login_signup/vet_signup.dart';
import 'package:petcare/tasarim_UI/tema.dart';

enum Option { Option1, Option2 }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Option selectedOption = Option.Option1;

  Widget getOption1Content() {
    return SingleChildScrollView(
      child: RegisterPage(),
    );
  }

  Widget getOption2Content() {
    return VetRegisterPage();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (selectedOption == Option.Option1) {
      content = getOption1Content();
    } else {
      content = getOption2Content();
    }
    return MaterialApp(
      theme: theme(),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight, // AppBar yüksekliğini ayarla
          centerTitle: true, // Başlığı ortala
          title: null, // Başlığı kaldır
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    selectedOption = Option.Option1;
                  });
                },
                child: const Text(
                  'Üye Ol',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    selectedOption = Option.Option2;
                  });
                },
                child: const Text(
                  'Veterinerim',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              content,
            ],
          ),
        ),
      ),
    );
  }
}
