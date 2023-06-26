import 'package:firebase_core/firebase_core.dart';
import 'package:petcare/tasarim_UI/bottom_bar.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:petcare/vet_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      // Diğer uygulama ayarları...
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: BottomBarUI());
    
      
    
  }
}
