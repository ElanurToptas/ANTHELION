import 'package:firebase_core/firebase_core.dart';
import 'package:petcare/tasarim_UI/bottom_bar.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'package:petcare/vet_pages/vet._main.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:petcare/vet_list.dart';
import 'package:petcare/tasarim_UI/home_page.dart';
import 'package:petcare/tasarim_UI/veterinarians_page.dart';
import 'package:petcare/tasarim_UI/services_page.dart';
import 'package:petcare/login_signup/login_screen.dart';

void main() {
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
    VeterinariansPage(),
    ServicesPage(),
    ProfilePage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Bar Örneği',
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
