﻿import 'package:flutter/material.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'package:petcare/vet_pages/vet_profile/edit_profile.dart';
import 'package:petcare/vet_pages/animal/vet._animal.dart';

class ButtonStyles {
  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 111, 132, 255),
    textStyle: TextStyle(fontSize: 18),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
    minimumSize: Size(120, 120),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Veteriner Profili'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyles.elevatedButtonStyle,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VetAnimal()),
                          );
                        },
                        child: Text('Hayvan Çip No'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        style: ButtonStyles.elevatedButtonStyle,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditVetProfile()),
                          );
                        },
                        child: Text('Profili Düzenle'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
