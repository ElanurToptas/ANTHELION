import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


ThemeData theme() {
  return ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: appBarTheme(),
  );
}


AppBarTheme appBarTheme(){
  return AppBarTheme(color: Colors.transparent
  );
}
/*class TemaUI {
  static  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.indigo,
    //fontFamily: baslik,
    
    );
  
 
  
}

 TextStyle baslik = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  //AppBarTheme appbar = AppBarTheme();*/