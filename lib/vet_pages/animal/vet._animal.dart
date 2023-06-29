import 'package:flutter/material.dart';

class ButtonStyles {
  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 111, 132, 255),
    textStyle: TextStyle(fontSize: 18),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
    minimumSize: Size(80, 80),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

class VetAnimal extends StatefulWidget {
  @override
  _SingleButtonWidgetState createState() => _SingleButtonWidgetState();
}

class _SingleButtonWidgetState extends State<VetAnimal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(49, 123, 93, 255),
        title: Text('Hayvan Döküman'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyles.elevatedButtonStyle,
                    onPressed: () {},
                    child: Text('Tahlil Sonuçları'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyles.elevatedButtonStyle,
                    onPressed: () {},
                    child: Text('Gelecek Aşıları'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyles.elevatedButtonStyle,
                    onPressed: () {},
                    child: Text('Hastalık Detayı'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyles.elevatedButtonStyle,
                    onPressed: () {},
                    child: Text('Randevu Ekranı'),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
