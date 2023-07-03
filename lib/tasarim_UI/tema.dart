import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily, 
      appBarTheme: appBarTheme(),
      elevatedButtonTheme: buttonTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.indigo,
      ),// imleç Rengi
      textTheme: TextTheme()
      );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: Colors.blueGrey.shade800),
    centerTitle: false,
    titleTextStyle: TextStyle(
      color:Colors.blueGrey.shade900,
      fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w400 ).fontFamily,
      fontSize: 20,
    )
  );
}

ElevatedButtonThemeData buttonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white), 
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 19,).fontFamily, 
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 20, vertical: 8), 
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
        ),
      ),
    ),
  );
}

OutlineInputBorder outlineBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.blueGrey.shade800, 
      width: 2.1),
    gapPadding: 10,
  );
}

OutlineInputBorder focusBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.indigo,
      width: 2.1),
    gapPadding: 10,

  );
}

InputDecorationTheme inputDecorationTheme() {
   return InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.blueGrey.shade800,
      fontWeight: FontWeight.w500), //Seçili Değilkenki Yazı Stili
    hintStyle: const TextStyle(color: Colors.indigo,), //Seçili Yazı Stili
    alignLabelWithHint: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal:40,vertical: 15),
    enabledBorder: outlineBorder(),
    focusedBorder: focusBorder(),
    border: outlineBorder(),
    
   );
}





