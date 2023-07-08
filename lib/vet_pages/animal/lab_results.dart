import 'package:flutter/material.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'package:petcare/vet_pages/vet_profile/edit_profile.dart';
import 'package:petcare/vet_pages/animal/vet._animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonStyles {
  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 111, 132, 255),
    textStyle: TextStyle(fontSize: 12),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    minimumSize: Size(10, 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

class ChipUpdatePage extends StatelessWidget {
  const ChipUpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String chipNumber = '';

    void updateChipNumber(String value) {
      chipNumber = value;
    }

    void getAnimalInformation() {
      String documentId = 'Chip ID'; // Dökümanın tam adını burada belirtin
      FirebaseFirestore.instance
          .collection('Pets')
          .doc(chipNumber)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // Hayvanın bilgileri başarıyla alındı, işlemleri burada gerçekleştirin
          var animalData = documentSnapshot.data();
          // Animal verilerini kullanarak yapmak istediğiniz işlemleri burada yapabilirsiniz
        } else {
          // Çip numarasına sahip hayvan bulunamadı, hata mesajı gösterebilirsiniz
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Hata'),
                content: Text('Çip numarasına sahip hayvan bulunamadı.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Tamam'),
                  ),
                ],
              );
            },
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hayvan Bilgilerini Getirme'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => updateChipNumber(value),
              decoration: InputDecoration(
                labelText: 'Hayvan Çip No',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyles.elevatedButtonStyle,
              onPressed: () {
                getAnimalInformation();
              },
              child: Text('Hayvan Bilgilerini Getir'),
            ),
          ],
        ),
      ),
    );
  }
}
