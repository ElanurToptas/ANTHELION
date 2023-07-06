import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcare/UserProfile.dart';
import 'package:petcare/tasarim_UI/vet._animal.dart';
import 'package:petcare/user_profile_pages/user_profile.dart';
import 'package:petcare/main.dart';

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

void getUserId() async {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String userId = user.uid;
    print('Kullanıcı Kimliği: $userId');
    // Kullanıcı kimliğini istediğiniz şekilde kullanabilirsiniz
  } else {
    print('Oturum açmış bir kullanıcı bulunamadı.');
  }
}

class EditVetProfile extends StatefulWidget {
  @override
  _EditVetProfileState createState() => _EditVetProfileState();
}

class _EditVetProfileState extends State<EditVetProfile> {
  File? _imageFile;
  String? _imageUrl;
  firebase_storage.Reference? _storageRef;
  String vetName = ''; // Kullanıcının adının tutulacağı değişken
  String vetBio = ''; // Kullanıcının bio tutulacağı değişken

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailFocused = false;
  double _containerHeight = 0.0;
  final FocusNode _emailFocusNode = FocusNode();
// Auth nesnesini almak için getAuth kullanımı
  final auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('Çıkış Yapıldı.');
    } catch (e) {
      print('Çıkış yapılırken bir hata oluştu: $e');
    }
  }

  void fetchUserName() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('Veterinarians').doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();
      if (data != null) {
        setState(() {
          vetName = data['name'] as String;
          _userNameController.text = vetName;
          String email = data['email'] as String;
          _emailController.text = email; // E-posta TextField'ına veriyi atama
        });
      }
    } else {
      print('Kullanıcı bulunamadı.');
    }
  }

  void saveUserEmail(String newEmail, String currentPassword) async {
    try {
      // Kullanıcıyı mevcut şifresiyle kimlik doğrulaması
      AuthCredential credential = EmailAuthProvider.credential(
        email: FirebaseAuth.instance.currentUser!.email!,
        password: currentPassword,
      );
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);

      // Firestore'da e-postayı güncelleme
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await _firestore
          .collection('Veterinarians')
          .doc(userId)
          .update({'email': newEmail});

      // Firebase Authentication'da e-postayı güncelleme
      await FirebaseAuth.instance.currentUser!.updateEmail(newEmail);

      setState(() {
        // E-posta güncellendikten sonra UI veya gerekli işlemleri yapabilirsiniz
      });
    } catch (e) {
      // Kimlik doğrulama veya güncelleme hatalarını yönetin
      if (e is FirebaseAuthException) {
        // Firebase Authentication hatalarını yönetin
        if (e.code == 'wrong-password') {
          print("Hata: Geçersiz şifre");
        } else {
          print("Hata: ${e.message}");
        }
      } else {
        // Diğer hataları yönetin
        print("Hata: $e");
      }
    }
  }

  void saveUserName(String newName) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await _firestore
        .collection('Veterinarians')
        .doc(userId)
        .update({'name': newName});

    setState(() {
      vetName = newName;
    });
  }

  void fetchUserBio() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('Veterinarians').doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();
      if (data != null) {
        setState(() {
          vetBio = data['bio'] as String;
          _bioController.text = vetBio;
        });
      }
    } else {
      print('Kullanıcı bulunamadı.');
    }
  }

  void saveUserBio(String newBio) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await _firestore
        .collection('Veterinarians')
        .doc(userId)
        .update({'bio': newBio});

    setState(() {
      vetBio = newBio;
    });
  }

// Kullanıcının şifresini güncellemek için updatePassword kullanımı
  void updatePassword() {
    User? user = auth.currentUser;
    if (user != null) {
      String newPassword = 'yeni_sifre';

      user.updatePassword(newPassword).then((_) {
        print('Şifre güncelleme başarılı.');
      }).catchError((error) {
        print('Şifre güncelleme hatası: $error');
      });
    }
  }

  void _updatePassword(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String currentPassword = _currentPasswordController.text;
      String newPassword = _newPasswordController.text;

      try {
        await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: user.email!, password: currentPassword),
        );

        await user.updatePassword(newPassword);
        print('Şifre güncelleme başarılı.');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Şifre güncelleme başarılı.'),
          ),
        );
      } catch (error) {
        print('Şifre güncelleme hatası: $error');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Şifre güncelleme hatası: $error'),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeStorageRef();
    _emailFocusNode.addListener(_onEmailFocusChange);
    _fetchImage();
    fetchUserBio();
    fetchUserName();
  }

  void _onEmailFocusChange() {
    setState(() {
      _isEmailFocused = _emailFocusNode.hasFocus;
      _containerHeight = _isEmailFocused ? 130.0 : 0.0;
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _initializeStorageRef() {
    final fileName =
        '${FirebaseAuth.instance.currentUser!.uid}_profile_image.jpg';
    _storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profile_picture')
        .child(fileName);
  }

  void _fetchImage() {
    _storageRef!.getDownloadURL().then((url) {
      setState(() {
        _imageUrl = url;
      });
    }).catchError((error) {
      setState(() {
        _imageUrl = null;
      });
      print('Profil resmi bulunamadı: $error');
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      File? imageFile = File(pickedFile.path);
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      // Resim seçilmediğinde yapılacak işlemler
      return;
    }

    String fileName =
        '${FirebaseAuth.instance.currentUser!.uid}_profile_image.jpg';

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profile_picture')
        .child(fileName);

    await ref.putFile(_imageFile!);

    setState(() {
      _imageUrl = ref.fullPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profil Düzenle'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                _imageFile != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(_imageFile!),
                      )
                    : _imageUrl != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(_imageUrl!),
                          )
                        : CircleAvatar(
                            radius: 60,
                            child: Text('Profil Resmi Yok'),
                          ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyles.elevatedButtonStyle,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Profil Resmi Güncelle'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                GestureDetector(
                                  child: Text('Galeriden Seç'),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(height: 16),
                                GestureDetector(
                                  child: Text('Kameradan Çek'),
                                  onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text('Profil Resmini Güncelle'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Ad',
                            hintText: 'Adınızı girin',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              vetName = value;
                            });
                          },
                          controller: _userNameController,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email adresiniz',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          onTap: () {
                            setState(() {
                              _isEmailFocused = true;
                            });
                          },
                          onEditingComplete: () {
                            setState(() {
                              _isEmailFocused = false;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              // _emailController'nin değeri değiştiğinde işlemler yapabilirsiniz.
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (_isEmailFocused)
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              _isEmailFocused = false;
                              _emailFocusNode.unfocus();
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: _containerHeight,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  _emailFocusNode.unfocus();
                                  _isEmailFocused = false;
                                });
                              },
                              child: Container(
                                height: 350,
                                child: Column(
                                  children: [
                                    TextField(
                                      obscureText: true,
                                      controller: _currentPasswordController,
                                      focusNode: _emailFocusNode,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Şifre',
                                        hintText: 'Şifrenizi giriniz',
                                        prefix: Icon(Icons.lock),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyles.elevatedButtonStyle,
                                      onPressed: () {
                                        String currentPassword =
                                            _currentPasswordController.text;
                                        String newEmail = _emailController.text;
                                        saveUserEmail(
                                            newEmail, currentPassword);
                                      },
                                      child: Text("E Postayı Güncelle"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 10),
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Bio',
                            hintText: 'Biyografinizi düzenleyin',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 50.0),
                          ),
                          onChanged: (value) {
                            setState(() {
                              vetBio = value;
                            });
                          },
                          maxLines: 8,
                          controller: _bioController,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: TextField(
                              obscureText: true,
                              controller: _currentPasswordController,
                              decoration: InputDecoration(
                                labelText: 'Mevcut Şifre',
                                hintText: 'Şifrenizi girin',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: TextField(
                              obscureText: true,
                              controller: _newPasswordController,
                              decoration: InputDecoration(
                                labelText: 'Yeni Şifre',
                                hintText: 'Yeni şifreyi girin',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Yeni Şifre Tekrar',
                                hintText: 'Yeni şifreyi tekrar girin',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ButtonStyles.elevatedButtonStyle,
                            onPressed: () {
                              String newPassword = _newPasswordController.text;
                              String confirmPassword =
                                  _confirmPasswordController.text;

                              if (newPassword == confirmPassword) {
                                _updatePassword(context);
                              } else {
                                // Şifreler eşleşmiyor, hata mesajı göster
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Hata'),
                                      content: Text(
                                          'Girdiğiniz şifreler eşleşmiyor.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Tamam'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text('Şifreyi Değiştir'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ButtonStyles.elevatedButtonStyle,
                  onPressed: () {
                    saveUserBio(vetBio);
                    saveUserName(vetName);
                    _uploadImage();
                  },
                  child: Text('Değişiklikleri Kaydet'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _signOut().then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    });
                  },
                  child: Text('Çıkış Yap'),
                ),
              ],
            ),
          ),
        ));
  }
}
