import 'package:flutter/material.dart';
import 'package:petcare/tasarim_UI/bottom_bar.dart';
import 'package:petcare/main.dart';

class EditVetProfile extends StatefulWidget {
  @override
  _EditVetProfileState createState() => _EditVetProfileState();
}

class _EditVetProfileState extends State<EditVetProfile> {
  @override
  void initState() {
    super.initState();
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
    );
  }
}
