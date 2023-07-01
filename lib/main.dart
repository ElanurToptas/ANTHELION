import 'package:firebase_core/firebase_core.dart';
import 'package:petcare/UserProfile.dart';
import 'package:petcare/animal/animal.dart';
import 'package:petcare/tasarim_UI/bottom_bar.dart';

import 'package:flutter/material.dart';

import 'package:petcare/tasarim_UI/home_page.dart';
import 'package:petcare/tasarim_UI/veterinarians_page.dart';
import 'package:petcare/tasarim_UI/services_page.dart';
import 'package:petcare/vet_list.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlatın

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pageOptions = [
    HomePage(),
    VetPage(),
    ServicesPage(),
    UsersProfile(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _pageOptions[_selectedIndex],
        bottomNavigationBar: BottomBar(
          selectedIndex: _selectedIndex,
          onTabSelected: _onTabSelected,
        ),
      ),
    );
  }
}
