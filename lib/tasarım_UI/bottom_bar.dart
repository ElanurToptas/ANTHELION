import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petcare/tasarım_UI/home_page.dart';
import 'package:petcare/tasarım_UI/veterinarians_page.dart';
import 'package:petcare/tasarım_UI/services_page.dart';
import 'package:petcare/vet_pages/vet._main.dart';
import 'package:petcare/login_signup/login_screen.dart';

void main() {
  runApp(BottomBarUI());
}

class BottomBarUI extends StatefulWidget {
  const BottomBarUI({Key? key});

  @override
  State<BottomBarUI> createState() => _BottomBarUIState();
}

class _BottomBarUIState extends State<BottomBarUI> {
  int _selectedIndex = 0; // Seçilen sekme indeksi
  final List<Widget> _pageOptions = [
    // İçerik sayfaları
    HomePage(),
    VeterinariansPage(),
    ServicesPage(),
    LoginScreen(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GNav(
            color: Colors.indigo,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.indigoAccent,
            selectedIndex: _selectedIndex,
            onTabChange: _onTabChanged,
            padding: EdgeInsets.all(20),
            tabs: const [
              GButton(icon: Icons.home_rounded, text: "Ana Sayfa"),
              GButton(icon: Icons.local_hospital_rounded, text: "Veterinerler"),
              GButton(icon: Icons.apartment_rounded, text: "Hizmetler"),
              GButton(icon: Icons.pets_rounded, text: "Profilim"),
            ],
          ),
        ),
      ),
      body: _pageOptions[
          _selectedIndex], // Seçilen sekme için ilgili içeriği gösterir
    );
  }
}
