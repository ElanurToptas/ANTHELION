import 'package:flutter/material.dart';

class ButtonStyles {
  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 111, 132, 255),
    textStyle: TextStyle(fontSize: 18),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    minimumSize: Size(10, 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

class VetAnimal extends StatefulWidget {
  @override
  _VetAnimalState createState() => _VetAnimalState();
}

class _VetAnimalState extends State<VetAnimal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(48, 69, 27, 255),
        title: Text('Hayvan Döküman'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 120,
                            child: ElevatedButton(
                              style: ButtonStyles.elevatedButtonStyle,
                              onPressed: () {},
                              child: Text('Tahlil Sonuçları'),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 120,
                            child: ElevatedButton(
                              style: ButtonStyles.elevatedButtonStyle,
                              onPressed: () {},
                              child: Text('Gelecek Aşıları'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 120,
                            child: ElevatedButton(
                              style: ButtonStyles.elevatedButtonStyle,
                              onPressed: () {},
                              child: Text('Hastalık Detayı'),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 120,
                            child: ElevatedButton(
                              style: ButtonStyles.elevatedButtonStyle,
                              onPressed: () {},
                              child: Text('Randevu Ekranı'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
