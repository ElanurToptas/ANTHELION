import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Veterinarian Profile'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              ElevatedButton(
                child: Text('Hayvan Çip No'),
                onPressed: () {
                  // Hayvan çip no butonuna tıklanınca yapılacak işlemler
                  // Buraya istediğiniz kodları ekleyebilirsiniz
                },
              ),
              ElevatedButton(
                child: Text('Profili Düzenle'),
                onPressed: () {
                  // Profili düzenle butonuna tıklanınca yapılacak işlemler
                  // Buraya istediğiniz kodları ekleyebilirsiniz
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
