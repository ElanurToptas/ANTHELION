import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TemaUI {
  static  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.indigo,
    );
  
  TextStyle HeaderOne = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 27,
    fontWeight: FontWeight.w800,
  );
  
}