import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petcare/user_profile_pages/user_profile.dart';
import 'package:petcare/vet_pages/vet._main.dart';

class AuthenticationService {
  static Future<User?> checkLoggedInUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(
      String uid) async {
    return FirebaseFirestore.instance.collection('Users').doc(uid).get();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getVeterinarianProfile(
      String uid) async {
    return FirebaseFirestore.instance.collection('Veterinarians').doc(uid).get();
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

void handleProfileButton(BuildContext context) async {
  User? user = await AuthenticationService.checkLoggedInUser();

  if (user != null) {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await AuthenticationService.getUserProfile(user.uid);
    DocumentSnapshot<Map<String, dynamic>> veterinarianSnapshot =
        await AuthenticationService.getVeterinarianProfile(user.uid);

    if (userSnapshot.exists) {
      // Kullanıcı profil sayfasına yönlendir
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfile(),
        ),
      );
    } else if (veterinarianSnapshot.exists) {
      // Veteriner profil sayfasına yönlendir
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProfilePage(),
        ),
      );
    }
  }
}
