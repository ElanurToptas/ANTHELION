import 'package:flutter/material.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'package:petcare/user_profile_pages/pages/user_diagnosis.dart';

import 'package:petcare/user_profile_pages/pages/user_edit_profile.dart';
import 'package:petcare/user_profile_pages/pages/user_lab_result.dart';
import 'package:petcare/user_profile_pages/pages/user_vaccines.dart';
// tema buton için
class ButtonStyles {
  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor:  Colors.deepPurple,
    textStyle: TextStyle(fontSize: 18),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
    minimumSize: Size(120, 120),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
class UserProfile extends StatelessWidget{
  
  
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      theme: theme(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(49, 123, 93, 255),
          title: Text('Kullanıcı Profili'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              //********************************************* Resmin Olduğu Yer *********************************************************
              Image.network(
              'https://www.medivet.co.uk/globalassets/assets/shutterstock-and-istock/shutterstock_708732331.png?width=585',
              width: 450, // Resmin genişliği
              height: 230, // Resmin yüksekliği
            ),
            //**************************************************************************************************************************** 
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(16),
                  /*decoration: BoxDecoration(
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
                  ),*/
                  child: Column(
                    children: [
                      // ****************************************************** İLK SIRA BUTONLAR ***************************************
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 120,width: 150,
                            child: ElevatedButton(
                              style: ButtonStyles.elevatedButtonStyle,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return PetDocumentsPage();
                })));
                              },
                              child: Text('     Tahlil \n Sonuçları'),
                            ),
                          ),
                          SizedBox(width: 16),
                          SizedBox(height: 120,width: 150,
                            child: ElevatedButton(
                              style: ButtonStyles.elevatedButtonStyle,
                              onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return YourPage();
                })));
                              },
                              child: Text('Gelecek \n Aşıları'),
                            ),
                          ),
                        ],
                      ),
                      //************************************************************************************************************************* 
                      SizedBox(height: 10,),
                      //************************************************* İKİNCİ SIRA BUTONLAR ************************************************
                       Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyles.elevatedButtonStyle,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return DiseasesPage();
                })));
                        },
                        child: Text('Hastalık Detayı'),
                      ),
                      SizedBox(width: 16),
                      SizedBox(height: 120, width: 150,
                        child: ElevatedButton(
                          style: ButtonStyles.elevatedButtonStyle,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return EditProfilePage();
                })));
                          },
                          child: Text('Profili Düzenle'),
                        ),
                      ),
                    ],
                  ),
                  //*************************************************************************************************************************** 
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
