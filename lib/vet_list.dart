import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:petcare/tasarim_UI/tema.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class VetPage extends StatefulWidget {
  @override
  _VetPageState createState() => _VetPageState();
}

class _VetPageState extends State<VetPage> {
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

  Future<Map<String, dynamic>?> _getVeterinarianData(
      String veterinarianUid) async {
    try {
      final snapshot = await _firestore
          .collection('Veterinarians')
          .doc(veterinarianUid)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        return data;
      }
    } catch (e) {
      print(
          'Error getting veterinarian data for veterinarian $veterinarianUid: $e');
    }
    return null;
  }

  late List<QueryDocumentSnapshot> veterinarians = [];
  late List<QueryDocumentSnapshot> filteredVeterinarians = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchVeterinarians();
  }

  void _fetchVeterinarians() async {
    try {
      var snapshot = await _firestore.collection('Veterinarians').get();
      setState(() {
        veterinarians = snapshot.docs;
        filteredVeterinarians = snapshot.docs;
      });
    } catch (e) {
      print('Error fetching veterinarians: $e');
    }
  }

  void _filterVeterinarians(String keyword) {
    setState(() {
      filteredVeterinarians = veterinarians.where((vet) {
        final name = (vet.data() as Map<String, dynamic>)['name']
            .toString()
            .toLowerCase();
        return name.contains(keyword.toLowerCase());
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Veteriner Ara!',
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              _filterVeterinarians(value);
            },
          ),
        ),
        body: ListView.builder(
          itemCount: filteredVeterinarians.length,
          itemBuilder: (context, index) {
            final vet = filteredVeterinarians[index];
            final veterinarianUid = vet.id;
            return FutureBuilder<String?>(
              future: _getVeterinarianProfilePictureUrl(veterinarianUid),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListTile(
                    leading: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data == null) {
                  return ListTile();
                }

                final profilePictureUrl = snapshot.data!;
                return FutureBuilder<Map<String, dynamic>?>(
                  future: _getVeterinarianData(veterinarianUid),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data == null) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                          ),
                        ),
                      );
                    }

                    final veterinarianData = snapshot.data!;
                    final veterinarianName =
                        veterinarianData['name'] as String?;
                    final veterinarianBio = veterinarianData['bio'] as String?;
                    final veterinarianAddress =
                        veterinarianData['address'] as String?;
                    final veterinarianPhone =
                        veterinarianData['phone number'] as String?;
                    final veterinarianUniversity =
                        veterinarianData['university'] as String?;
                    final veterinarianPets =
                        veterinarianData['species'] as String?;

                    if (veterinarianName == null || veterinarianBio == null) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                          ),
                        ),
                      );
                    }
return GestureDetector(
  onTap: () {
    _showVeterinarianDetails(
      veterinarianName,
      veterinarianBio,
      profilePictureUrl,
      veterinarianAddress,
      veterinarianPhone,
      veterinarianUniversity,
      veterinarianPets,
    );
  },
  child: Card(
    elevation: 5,
    child: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Veteriner $veterinarianName',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 115,
                height: 170
                ,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    profilePictureUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16, height: 75,),
              Expanded(
                child: Text(
                  veterinarianBio.length > 190
                      ? '${veterinarianBio.substring(0, 190
                      )}...'
                      : veterinarianBio,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);



                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showVeterinarianDetails(
  veterinarianName,
  veterinarianBio,
  profilePictureUrl,
  veterinarianAddress,
  veterinarianPhone,
  veterinarianUniversity,
  veterinarianPets,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Veteriner $veterinarianName',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  width: 270,
                  height: 270,
                  child: Image.network(
                    profilePictureUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                veterinarianBio,
                style: TextStyle(
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16),
              if (veterinarianAddress != null)
                Text(
                  'Adres: $veterinarianAddress',
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
              if (veterinarianUniversity != null)
                Text(
                  'Mezun Olduğu Okul: $veterinarianUniversity',
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
              if (veterinarianPets != null)
                Text(
                  'Baktığı Hayvan Türleri: $veterinarianPets',
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (veterinarianPhone != null) {
                    _contactVeterinarian(veterinarianPhone);
                  }
                },
                child: Text(
                  'İletişime Geç',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Kapat',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
      );
    },
  );
}

  void _addAddress(String address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AlertDialog(
            title: Text(
              'Adres',
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              address,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Kapat',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _contactVeterinarian(String phone) async {
  if (phone != null && phone.isNotEmpty) {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Hata',
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'İşlem Gerçekleştirilemedi!',
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Kapat',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Uyarı',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Daha Sonra Tekrar Deneyin!',
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Kapat',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  }
}