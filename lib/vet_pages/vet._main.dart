import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'package:petcare/vet_pages/animal/lab_results.dart';
import 'package:petcare/vet_pages/animal/vaccines.dart';
import 'package:petcare/vet_pages/vet_profile/edit_profile.dart';
import 'package:petcare/vet_pages/animal/vet._animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcare/vet_pages/animal/disease_diagnosis.dart';
import 'package:petcare/vet_pages/animal/vaccines.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonStyles {
  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
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
          title: Text('Hayvan Bilgilerini Getir'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/ArkaPlan/Arka Plan.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
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
        ));
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
          title: Text('Hayvan Bilgileri'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/ArkaPlan/Arka Plan.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/Kullanıcı/vet bilgi.png',
                ),
                Text(
                  'Hayvan Çip Numarası: $chipNumber',
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LabResults(
                                          chipNumber: chipNumber,
                                        ),
                                      ),
                                    );
                                  },
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Vaccines(
                                          chipNumber: chipNumber,
                                        ),
                                      ),
                                    );
                                  },
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
                                        builder: (context) =>
                                            DiseaseDiagnosisPage(
                                          chipNumber: chipNumber,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Hastalık Detayı'),
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
        ));
  }
}

final FirebaseStorage _storage = FirebaseStorage.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<String?> _getVeterinarianProfilePictureUrl(
      String veterinarianUid) async {
    try {
      final ref = _storage
          .ref()
          .child('profile_picture/${veterinarianUid}_profile_image.jpg');
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print(
          'Error getting profile picture URL for veterinarian $veterinarianUid: $e');
      return null;
    }
  }

  Future<String?> _getVeterinarianName(String veterinarianUid) async {
    final vetSnapshot = await FirebaseFirestore.instance
        .collection('Veterinarians')
        .doc(veterinarianUid)
        .get();
    if (vetSnapshot.exists) {
      final data = vetSnapshot.data();
      final name = data?['name'] ?? '';
      return name;
    }
    return null;
  }

  Future<String?> _getVeterinarianUid() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final uid = currentUser.uid;
      final vetSnapshot = await FirebaseFirestore.instance
          .collection('Veterinarians')
          .doc(uid)
          .get();
      if (vetSnapshot.exists) {
        return uid;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veteriner Profili'),
      ),
      body: FutureBuilder<String?>(
        future: _getVeterinarianUid(),
        builder: (context, uidSnapshot) {
          if (uidSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final veterinarianUid = uidSnapshot.data;
          return FutureBuilder<String?>(
            future: _getVeterinarianProfilePictureUrl(veterinarianUid!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final imageUrl = snapshot.data;
              return FutureBuilder<String?>(
                future: _getVeterinarianName(veterinarianUid),
                builder: (context, nameSnapshot) {
                  if (nameSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final veterinarianName = nameSnapshot.data;
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('asset/ArkaPlan/Arka Plan.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: imageUrl != null
                                        ? NetworkImage(imageUrl)
                                        : AssetImage(
                                                'asset/Kullanıcı/vet bilgi.png')
                                            as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Hoşgeldiniz, $veterinarianName',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
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
                                  child: Text('Hasta Bilgileri'),
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
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
