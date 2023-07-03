import 'package:firebase_core/firebase_core.dart';
import 'package:petcare/UserProfile.dart';
import 'package:petcare/animal/animal.dart';
import 'package:petcare/tasarim_UI/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:petcare/tasarim_UI/services_page.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'package:petcare/vet_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();

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

  Widget _buildAppBar() {
    if (_selectedIndex == 0) {
      return AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Geri butonuna basıldığında yapılacak işlemler
                // Örneğin, arama ekranını kapatma gibi
                print('Geri butonuna basıldı');
              },
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Aramak İstediğiniz Kelimeyi Girin',
                  suffixIcon: Icon(Icons.search),
                ),
                onSubmitted: (value) {
                  // Arama işlemini burada gerçekleştirin
                  // Örneğin, listenin filtrelenmesi veya veritabanı sorgusu gibi
                  print('Aranan kelime: $value');
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return AppBar(
        // Diğer AppBar özellikleri
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Bar',
      theme: theme(),
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
