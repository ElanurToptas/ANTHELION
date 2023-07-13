import 'package:flutter/material.dart';
import 'package:petcare/user_profile_pages/user_profile.dart';
import 'package:petcare/vet_pages/vet._main.dart';
import 'package:petcare/login_signup/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersProfile extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(), // Oturum durumunu dinleyen bir stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            // Kullanıcı oturum açmamışsa giriş sayfasına yönlendir
            return LoginScreen();
          } else {
            // Kullanıcı oturum açmışsa kullanıcının UID'sini al
            final String uid = user.uid;

            // Firestore'da Users koleksiyonunda kullanıcıyı sorgula
            return StreamBuilder<DocumentSnapshot>(
              stream: _firestore.collection('Users').doc(uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final DocumentSnapshot userSnapshot = snapshot.data!;
                  if (userSnapshot.exists &&
                      userSnapshot.get('isUser') == 'true') {
                    // Kullanıcı UID'si User koleksiyonunda bir belgeyle eşleşiyorsa UserProfile sayfasına yönlendir
                    return UserProfile();
                  }
                }
                // Kullanıcı UID'si User koleksiyonunda bir belgeyle eşleşmiyorsa veya hata varsa, Veterinarians koleksiyonunda sorgula
                return StreamBuilder<DocumentSnapshot>(
                  stream: _firestore
                      .collection('Veterinarians')
                      .doc(uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final DocumentSnapshot vetSnapshot = snapshot.data!;
                      if (vetSnapshot.exists &&
                          vetSnapshot.get('isVet') == 'true') {
                        // Kullanıcı UID'si Veterinarians koleksiyonunda bir belgeyle eşleşiyorsa ProfilePage sayfasına yönlendir
                        return ProfilePage();
                      }
                    }
                    // Kullanıcı UID'si Veterinarians koleksiyonunda bir belgeyle eşleşmiyorsa veya hata varsa, bir hata mesajı göster
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Yetkisiz kullanıcı! Moderatörler Veterinerlik yeterliliğinizi onaylayana kadar bu hesap askıdadır.',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Kullanıcıyı çıkış yapmaya yönlendir
                              FirebaseAuth.instance.signOut();
                            },
                            child: Text('Yeniden Giriş Yap'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        } else {
          // Bağlantı durumu bekleniyor ise yüklenme göster
          return CircularProgressIndicator();
        }
      },
    );
  }
}
