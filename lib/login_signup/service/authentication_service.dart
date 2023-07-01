import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServiceProvider with ChangeNotifier {
  bool _isSignedIn = false;
  String _userType = '';

  bool get isSignedIn => _isSignedIn;
  String get userType => _userType;

  Future<void> signIn() async {
    // Kullanıcının giriş işlemini gerçekleştirin
    // Firebase veya başka bir kimlik doğrulama sağlayıcısı kullanabilirsiniz
    // Giriş başarılı olduğunda _isSignedIn değerini true olarak ayarlayın
    _isSignedIn = true;
    _userType = await determineUserType(); // Kullanıcının tipini belirleyin
    notifyListeners();
  }

  Future<String> determineUserType() async {
    // Kullanıcının tipini belirlemek için Firestore sorgusu yapın
    String uid = ''; // Kullanıcının UID'sini burada alın
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('User').doc(uid).get();
    DocumentSnapshot vetSnapshot = await FirebaseFirestore.instance.collection('Veterinarians').doc(uid).get();

    if (userSnapshot.exists) {
      return 'user';
    } else if (vetSnapshot.exists) {
      return 'vet';
    } else {
      return '';
    }
  }

  Future<void> signOut() async {
    // Kullanıcının çıkış işlemini gerçekleştirin
    // Firebase veya başka bir kimlik doğrulama sağlayıcısı kullanabilirsiniz
    // Çıkış başarılı olduğunda _isSignedIn değerini false olarak ayarlayın
    _isSignedIn = false;
    _userType = '';
    notifyListeners();
  }
}

