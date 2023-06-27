import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const BottomBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GNav(
          color: Colors.indigo,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.indigoAccent,
          selectedIndex: selectedIndex,
          onTabChange: onTabSelected,
          padding: EdgeInsets.all(20),
          tabs: const [
            GButton(icon: Icons.home_rounded, text: "Ana Sayfa"),
            GButton(icon: Icons.local_hospital_rounded, text: "Veterinerler"),
            GButton(icon: Icons.apartment_rounded, text: "Hizmetler"),
            GButton(icon: Icons.pets_rounded, text: "Profilim"),
          ],
        ),
      ),
    );
  }
}
