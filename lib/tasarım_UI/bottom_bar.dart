import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBarUI extends StatefulWidget {
  const BottomBarUI({super.key});

  @override
  State<BottomBarUI> createState() => _BottomBarUIState();
}

class _BottomBarUIState extends State<BottomBarUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container( color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GNav(
             //backgroundColor: Colors.indigo,
             color: Colors.indigo,
             activeColor: Colors.white,
             tabBackgroundColor: Colors.indigoAccent,
             onTabChange: (index) {
              print(index);
             },
              padding: EdgeInsets.all(20),
              
              tabs: const[
                GButton(icon: Icons.home_rounded, text: "Ana Sayfa", ),
                GButton(icon: Icons.local_hospital_rounded, text: "Veterinerler",),
                GButton(icon: Icons.apartment_rounded, text: "Hizmetler",),
                GButton(icon: Icons.pets_rounded ,text: "Profilim",),
              
              ],
              ),
          ),
        ),
      );
   
  }
}