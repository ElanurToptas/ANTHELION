import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';

const SizedBox _sizedBoxHeight10 = SizedBox(height: 10);

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _namesurnameController = TextEditingController();
  List<Map<String, dynamic>> _pets = [];

  void _navigateToAnotherPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Bilgilerim",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    _sizedBoxHeight10,
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: 'E-mail', border: InputBorder.none),
                      ),
                    ),
                    _sizedBoxHeight10,
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _namesurnameController,
                        decoration: InputDecoration(
                            labelText: 'Ad Soyad', border: InputBorder.none),
                      ),
                    ),
                    _sizedBoxHeight10,
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            labelText: 'Parola', border: InputBorder.none),
                        obscureText: true,
                      ),
                    ),
                    _sizedBoxHeight10,
                    DecoratedBox(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                            labelText: 'Parola Tekrar',
                            border: InputBorder.none),
                        obscureText: true,
                      ),
                    ),
                    _sizedBoxHeight10,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _pets.length,
                      itemBuilder: (context, index) {
                        final pet = _pets[index];
                        List<Map<String, dynamic>> vaccines =
                            (pet['vaccines'] as List<dynamic>)
                                .cast<Map<String, dynamic>>();
                        return Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Evcil Hayvan Chip ID',
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    pet['chipId'] = value;
                                  });
                                },
                              ),
                            ),
                            _sizedBoxHeight10,
                            Text(
                              'Aşı Bilgileri (Yapılmış Aşılar)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Column(
                              children: vaccines.map((vaccine) {
                                final dateTime =
                                    (vaccine['date'] as Timestamp).toDate();
                                final formattedDate =
                                    '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                                return ListTile(
                                  title: Text(vaccine['name']),
                                  subtitle: Text(formattedDate),
                                );
                              }).toList(),
                            ),
                            _sizedBoxHeight10,
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Aşı Adı',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        pet['vaccineName'] = value;
                                      });
                                    },
                                  ),
                                ),
                                _sizedBoxHeight10,
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      _selectDate(index);
                                    },
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: pet['vaccineDate'] != null
                                              ? pet['vaccineDate']
                                              : '',
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Tarih',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                _sizedBoxHeight10,
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      vaccines.add({
                                        'name': pet['vaccineName'],
                                        'date': Timestamp.fromDate(
                                          DateTime.parse(pet['vaccineDate']),
                                        ),
                                      });
                                      pet['vaccines'] = vaccines;
                                      pet['vaccineName'] = '';
                                      pet['vaccineDate'] = '';
                                    });
                                  },
                                  child: Text('Ekle'),
                                ),
                              ],
                            ),
                            _sizedBoxHeight10,
                          ],
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _pets.add({
                            'chipId': '',
                            'vaccines': [],
                            'vaccineName': '',
                            'vaccineDate': '',
                          });
                        });
                      },
                      child: Text('Evcil Hayvan Ekle'),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      width: 345,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _passwordController.text ==
                                  _confirmPasswordController.text) {
                            _register();
                            _navigateToAnotherPage();
                          } else {
                            var snackBar = SnackBar(
                                content: Text('E-mail veya Parola Hatalı !'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text(
                          'Kayıt Ol',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _pets[index]['vaccineDate'] = picked.toString();
      });
    }
  }

  void _register() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      String uid = userCredential.user!.uid;
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(uid);

      List<Map<String, dynamic>> pets = [];
      for (var pet in _pets) {
        String chipId = pet['chipId'];
        List<Map<String, dynamic>> vaccines =
            (pet['vaccines'] as List<dynamic>).cast<Map<String, dynamic>>();

        Map<String, dynamic> vaccinesMap = {};
        for (var vaccine in vaccines) {
          vaccinesMap[vaccine['name']] = vaccine['date'];
        }

        DocumentReference petDocRef =
            FirebaseFirestore.instance.collection('Pets').doc(chipId);

        await petDocRef.set({
          'chipId': chipId,
          'vaccines': vaccinesMap,
        });

        pets.add({
          'chipId': chipId,
        });
      }

      await userDocRef.set({
        'name': _namesurnameController.text,
        'email': userCredential.user!.email,
        'isUser': "true",
        'pets': pets,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
