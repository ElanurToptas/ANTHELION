import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class VeterinariansPage extends StatefulWidget {
  @override
  _VeterinariansPageState createState() => _VeterinariansPageState();
}

class _VeterinariansPageState extends State<VeterinariansPage> {
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
    try {
      final snapshot = await _firestore
          .collection('Veterinarians')
          .doc(veterinarianUid)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return data['name'] as String?;
        }
      }
    } catch (e) {
      print(
          'Error getting veterinarian name for veterinarian $veterinarianUid: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veterinarians'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Veterinarians').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No veterinarians found.');
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final veterinarianUid = document.id;
              return FutureBuilder<String?>(
                future: _getVeterinarianProfilePictureUrl(veterinarianUid),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text('Loading...'),
                      leading: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data == null) {
                    return ListTile(
                      title: Text('Error'),
                      leading: Icon(Icons.error),
                    );
                  }

                  final profilePictureUrl = snapshot.data!;
                  return FutureBuilder<String?>(
                    future: _getVeterinarianName(veterinarianUid),
                    builder: (BuildContext context,
                        AsyncSnapshot<String?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(
                          title: Text('Loading...'),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(profilePictureUrl),
                          ),
                        );
                      }

                      if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data == null) {
                        return ListTile(
                          title: Text('Error'),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(profilePictureUrl),
                          ),
                        );
                      }

                      final veterinarianName = snapshot.data!;
                      return ListTile(
                        title: Text(veterinarianName),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profilePictureUrl),
                        ),
                      );
                    },
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
