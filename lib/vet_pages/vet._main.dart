import 'package:flutter/material.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'package:petcare/vet_pages/vet_profile/edit_profile.dart';
import 'package:petcare/vet_pages/animal/vet._animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcare/vet_pages/animal/disease_diagnosis.dart';

class ButtonStyles {
  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 111, 132, 255),
    textStyle: TextStyle(fontSize: 18),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    minimumSize: Size(120, 120),
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
      FirebaseFirestore.instance
          .collection('Pets')
          .doc(chipNumber)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // Hayvanın bilgileri başarıyla alındı, işlemleri burada gerçekleştirin
          var animalData = documentSnapshot.data();
          // Animal verilerini kullanarak yapmak istediğiniz işlemleri burada yapabilirsiniz

          // Seçilen hayvanın bilgilerini değiştirmek için düzenleme sayfasına yönlendir
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditAnimalPage(chipNumber: chipNumber),
            ),
          );
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

class EditAnimalPage extends StatelessWidget {
  final String chipNumber;

  const EditAnimalPage({required this.chipNumber});

  @override
  Widget build(BuildContext context) {
    // Seçilen ID'ye göre düzenleme yapmak için burada gerekli arayüzü oluşturun ve işlemleri gerçekleştirin
    return Scaffold(
      appBar: AppBar(
        title: Text('Hayvan Düzenleme Sayfası'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Seçilen Hayvanın ID\'si: $chipNumber',
              style: TextStyle(fontSize: 24),
            ),
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DiseaseDiagnosisPage(
                                      chipNumber: chipNumber,
                                    ),
                                  ),
                                );
                              },
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
            // Düzenleme için gerekli arayüzü buraya ekleyin
            // İşlemleri gerçekleştirecek butonları buraya ekleyin
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Veteriner Profili'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(16),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyles.elevatedButtonStyle,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChipUpdatePage(),
                            ),
                          );
                        },
                        child: Text('Hasta Bilgilerini Getir'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        style: ButtonStyles.elevatedButtonStyle,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditVetProfile(),
                            ),
                          );
                        },
                        child: Text('Profili Düzenle'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
