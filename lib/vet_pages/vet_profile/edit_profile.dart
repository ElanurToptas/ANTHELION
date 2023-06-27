import 'package:flutter/material.dart';
import 'package:petcare/tasarim_UI/bottom_bar.dart';
import 'package:petcare/main.dart';

class EditVetProfile extends StatefulWidget {
  final int selectedIndex;

  EditVetProfile({required this.selectedIndex});

  @override
  _EditVetProfileState createState() => _EditVetProfileState();
}

class _EditVetProfileState extends State<EditVetProfile> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sayfa 1'),
      ),
      body: Center(
        child: Text('Sayfa 1 içeriği'),
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onTabSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Burada sayfa değişimi gerçekleştirebilirsiniz
        },
      ),
    );
  }
}
