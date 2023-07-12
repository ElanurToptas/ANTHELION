import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:url_launcher/url_launcher.dart';
import '../tasarim_UI/tema.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: ServicesPage(),
    );
  }
}

class MyCard {
  List<List<String>> titles;
  List<List<String>> descriptions;
  String imagePath;

  MyCard({
    required this.titles,
    required this.imagePath,
    required this.descriptions,
  });
}

class ServicesPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final List<String> names = [
    'Pet Paradise Oteli',
    'Paws & Claws Evcil Hayvan Spa ve Tatil Köyü',
    'Happy Tails Evcil Hayvan Resort',
    'Ayşe Yılmaz',
    'Ramazan Kaya',
    'Zeynep Acar',
    'Evcil Cennet',
    'Patili Dükkan',
    'Sevimli Köşe',
    "Pampered Paws",
    "Furry Styles",
    "Paws & Co.",
    "Pawsitive Pups",
    "Canine Academy",
    "Smart Paws Training Center"
  ];

  void _showCard(BuildContext context, MyCard card) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    card.imagePath,
                    width: 150,
                    height: 140,
                  ),
                  SizedBox(height: 10),
                  Column(
                      children: List.generate(
                        card.titles.length,
                            (index) {
                          List<String> titleGroup = card.titles[index];
                          List<String> descriptionGroup = card.descriptions[index];

                          return Column(
                            children: List.generate(
                              titleGroup.length,
                                  (innerIndex) {
                                String title = titleGroup[innerIndex];
                                String description = descriptionGroup[innerIndex];

                                return Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      description,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: 1),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          launch('tel:+123456789');
                        },
                        child: Text('Telefon'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          launch('https://www.google.com');
                        },
                        child: Text('Web Sitesi'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Kapat'),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Container(
            height: 75,
            padding: EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Hizmet Ara",
                    hintStyle: TextStyle(fontSize: 17),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return _getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  _searchController.clear();
                  if (suggestion == "Pet Paradise Oteli") {
                    MyCard card = MyCard(
                      titles: [["Pet Paradise Oteli"],
                        ['Evcil dostlarınızın rüya tatili'],
                      ],
                      descriptions: [[""],
                        ["Lüks konaklama birimleri ve geniş açık alanlarla donatılmış olan Pet Paradise Oteli, "
                            "evcil dostlarınızın unutulmaz bir tatil deneyimi yaşaması için tasarlanmıştır."
                            "Profesyonel ve sevgi dolu personelimiz, 24/7 gözetim altında evcil hayvanlarınıza"
                            " özenli bir şekilde hizmet vermektedir.Otelimizde köpekler ve kediler için ayrı ayrı"
                            " tasarlanmış konaklama birimleri, özel oyun alanları ve günlük aktiviteler sunulmaktadır.",
                      ],],
                      imagePath: 'asset/pictures-2/norfolkT.png',
                    );
                    _showCard(context, card);
                  }
                  if (suggestion == "Paws & Claws Evcil Hayvan Spa ve Tatil Köyü") {
                    MyCard card = MyCard(
                      titles:[["Paws & Claws Evcil Hayvan Spa ve Tatil Köyü"],
                        ["Evcil dostlarınıza şımartıcı bir kaçamak"],],
                      descriptions:[ [""],
                        ["Paws & Claws Oteli, evcil hayvanınızın tatilini unutulmaz kılmak için lüks konaklama seçenekleri, spa hizmetleri ve eğlenceli aktiviteler sunar."
                          "Profesyonel veterinerler ve bakım uzmanları, evcil dostlarınızın sağlık ve mutluluğu için özenle ilgilenir."
                          "Otelimizde evcil hayvanlarınız için özel yüzme havuzları, oyun alanları ve doğa yürüyüş parkurları bulunur.",],],
                      imagePath: 'asset/pictures-2/collie.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Happy Tails Evcil Hayvan Resort") {
                    MyCard card = MyCard(
                      titles:[[""],
                        ["Mutlu anılar için mükemmel tatil mekan",],],
                      descriptions:[["Happy Tails Evcil Hayvan Resort"],
                        [" Happy Tails Resort, evcil dostlarınızı ağırlarken onlara sevgi, güven ve eğlence dolu bir ortam sunar."
                          "Geniş ve rahat konaklama birimlerimizde evcil hayvanlarınız kendilerini evlerinde hissedecekler."
                          "Otelimizde özel yürüyüş parkurları, oyun grupları ve veteriner hizmetleri gibi birçok olanak bulunur. "],],
                      imagePath:  'asset/pictures-2/goldenR.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Ayşe Yılmaz") {
                    MyCard card = MyCard(
                      titles:[
                        ["Ayşe Yılmaz"],
                        ["Benimle Evcil Hayvanınız Güvende!"],
                        ["Hizmetlerim:"],
                      ],
                      descriptions:[[""],
                        ["Merhaba! Ben hayvan bakıcısı olarak uzun yıllardır hizmet veren biriyim. "
                          "Evcil hayvanınıza sevgi, ilgi ve güvence sağlamak için buradayım."],
                         [ "Evde veya evinizde evcil hayvanınıza göz kulak olmak."
                          "Beslenme, yürüyüş ve egzersiz programı oluşturmak."
                          "Tuvalet ihtiyaçlarını temizlemek ve hijyenik ortam sağlamak."
                          "İlaç vermek ve tıbbi bakım sağlamak (gerektiğinde)."
                          "Oyun oynamak, sevgi dolu etkileşimlerde bulunmak.",],],
                      imagePath:'asset/pictures-2/chartreux.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Ramazan Kaya") {
                    MyCard card = MyCard(
                      titles:[
                        ["Ramazan Kaya"],
                        ["Profesyonel Evcil Hayvan Bakıcısı"],
                        ["Hizmetlerim:"],
                      ],
                      descriptions:[[""],
                        ["Merhaba! Hayvansever ve sorumluluk sahibi bir hayvan bakıcısıyım. Evcil hayvanınıza gereken sevgi, ilgi ve bakımı sağlamak için buradayım."],
                         [ "Günlük beslenme, su değişimi ve tuvalet ihtiyaçlarını karşılamak."
                          "Yürüyüş, egzersiz ve oyun programı oluşturmak."
                          "Evcil hayvanınıza ilaç vermek ve tıbbi bakım sağlamak."
                          "Evde veya evinizde güvenli bir ortam oluşturmak."
                          "Evcil hayvanınıza sevgi dolu etkileşimlerde bulunmak.",],],
                      imagePath:'asset/pictures-2/europeanS.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Zaynep Acar") {
                    MyCard card = MyCard(
                      titles:[
                        ["Zaynep Acar"],
                        ["Evcil Hayvan Bakımı için Profesyonel Yardım"],
                        ["Hizmetlerim:"],
                      ],
                      descriptions:[[""],
                        ["Merhaba! Hayvansever ve sorumluluk sahibi bir hayvan bakıcısıyım. "
                    "Evcil hayvanınıza gereken sevgi, ilgi ve bakımı sağlamak için buradayım."],
                       [ "Günlük beslenme, su değişimi ve tuvalet ihtiyaçlarını karşılamak."
                          "Yürüyüş, egzersiz ve oyun programı oluşturmak."
                          "Evcil hayvanınıza ilaç vermek ve tıbbi bakım sağlamak."
                          "Evde veya evinizde güvenli bir ortam oluşturmak."
                          "Evcil hayvanınıza sevgi dolu etkileşimlerde bulunmak."],],
                      imagePath:'asset/pictures-2/scottishF.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Evcil Cennet") {
                    MyCard card = MyCard(
                      titles:[["Evcil Cennet"],
                        ["Tüylü dostlarınızın cenneti!"],
                      ],
                      descriptions:[[""],
                        ["Köpek maması, kedi kumu, oyuncaklar, tasma ve tasarım evcil hayvan eşyaları."],],
                      imagePath:'asset/pictures-2/çinH.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Patili Dükkan") {
                    MyCard card = MyCard(
                      titles:[["Patili Dükkan"],
                        ["Patilerinize özel bir alışveriş deneyimi!"],],
                      descriptions:[[""],
                        ["Köpek mamaları ve atıştırmalıklar, kedi kumu ve kedi maması, "
                      "kuş yemleri ve kafesler, akvaryum malzemeleri."],],
                      imagePath: 'asset/pictures-2/avrupaH.png',
                    );
                    _showCard(context, card);
                  }


                  if (suggestion == "Sevimli Köşe") {
                    MyCard card = MyCard(
                      titles:[["Sevimli Köşe"],
                        ["Sevgi dolu evcil hayvanlar için doğru adres!"],],
                      descriptions:[[""],
                        ["Köpek ve kedi mamaları, evcil hayvan oyuncakları,"
                      " kuş kafesleri, balık tankları ve akvaryum malzemeleri. "],],
                      imagePath:  'asset/pictures-2/gonzalesH.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Pampered Paws") {
                    MyCard card = MyCard(
                      titles:[["Pampered Paws"],
                        ["Patileri şımartan bir dokunuş!"],],
                      descriptions:[[""],
                        ["Köpek ve kedi tımarı, tüy kesimi, yıkanma ve kurutma,"
                      " tırnak kesimi, kulak temizliği, taraklama ve özel cilt bakımı."],],
                      imagePath:  "asset/pictures-2/Hothot tavşanı (2).png",
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Furry Styles") {
                    MyCard card = MyCard(
                      titles:[["Furry Styles"],
                        ["Kişilik & Karakter Özellikleri"],],
                      descriptions:[[""],
                        ["Tüy kesimi ve şekillendirme, yaratıcı tımar stilleri, renkli tüy boyama, köpük banyolar, tırnak cilalama, göz ve kulak temizliği."],],
                      imagePath:  'asset/pictures-2/Hollanda Lop tavşanı (2).png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Paws & Co.") {
                    MyCard card = MyCard(
                      titles:[["Paws & Co."],
                        ["Sağlıklı tüyler, mutlu patiler!"],],
                      descriptions:[[""],
                        ["Tüy kesimi, yıkanma ve kurutma, fırçalama, tırnak bakımı, koku giderme,"
                      " cilt ve tüy bakımı, spa tedavileri, özel tımar paketleri."],],
                      imagePath: 'asset/pictures-2/Havana tavşanı (2).png',
                    );
                    _showCard(context, card);
                  }
                  if (suggestion == "Pawsitive Pups") {
                    MyCard card = MyCard(
                      titles:[["Pawsitive Pups"],
                        ["Köpeğinizle pozitif bir bağ kurun!"],],
                      descriptions:[[""],
                        ["Bazı tavşanlar birçok oyuncakla eğlenmeye ihtiyaç duyarlar "
                          "(bir mağaza satın alınmış mı yoksa tuvalet kağıdı rulosu kadar basit bir şey "
                          "tamamen size bağlıdır), diğerleri onları mutlu etmek için fazla bir şeye ihtiyaç duymaz."
                          " Her biri, evcil hayvanınızın kendi muhafazaları dışında çok sayıda oyun süresiyle "
                          "keşfetmesi gereken tavşanınızın kişiliğine bağlıdır.Bu tavşan eğitim lazım olduğunda,"
                          " bir kedi ya da köpek gibi başka bir evcil hayvan eğitimi daha önemli olduğunu"
                          " görebilirsiniz. Daha zorlu olsa da, tavşanlar eğitmek kesinlikle imkansız değil"
                          " ama diğer hayvanlara göre daha fazla sabır ve zaman gerektiriyorlar. "
                          "Birçok evcil hayvan ailesi, evin etrafına birkaç çöp kutusu yerleştirmenin "
                          "en iyi şekilde işe yaradığını fark etti, çünkü tavşanı yapmak için tavşanınızın "
                          "evinizin diğer tarafına gitmesi gerekmiyor."],],
                      imagePath: 'asset/pictures-2/Havana tavşanı (2).png',
                    );
                    _showCard(context, card);
                  }
                  if (suggestion == "Cannie Academy") {
                    MyCard card = MyCard(
                      titles:[ ["Cannie Academy"],
                        ["Köpeğinizi eğitirken en iyiyi arayın!"],],
                      descriptions:[ [""],
                        ["Temel komut eğitimi, problem davranış düzeltme, köpek davranış analizi,"
                      " sosyalizasyon, çevre uyum eğitimi, terapi köpeği eğitimi."],],
                      imagePath: 'asset/pictures-2/Havana tavşanı (2).png',
                    );
                    _showCard(context, card);
                  }
                  if (suggestion == "Smart Paws Training Center") {
                    MyCard card = MyCard(
                      titles:[["Smart Paws Training Center"],
                        ["Zekice eğitilmiş patiler!"],],
                      descriptions:[[""],
                        ["Temel itaat eğitimi, yürüyüş eğitimi, sosyalleşme, problem davranışların düzeltilmesi,"
                      " ileri itaat eğitimi, köpek sporları eğitimi."],],
                      imagePath: 'asset/pictures-2/Havana tavşanı (2).png',
                    );
                    _showCard(context, card);
                  }



                },
              ),

            ),
          ),
        ),
      ), // buradan sonra iconlar bulunuyor üst kısım ise arama kısmı
      body:  SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(width: MediaQuery.of(context).size.width,
              height: 28,
              child:Stack(
                children: [
                  Text(
                    'Köpekler', style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Container(
              width: MediaQuery.of(context).size.width -0,
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[['Evcil dostlarınızın rüya tatili'],],
                                    descriptions:[["Lüks konaklama birimleri ve geniş açık alanlarla donatılmış olan Pet Paradise Oteli, "
                                        "evcil dostlarınızın unutulmaz bir tatil deneyimi yaşaması için tasarlanmıştır."
                                        "Profesyonel ve sevgi dolu personelimiz, 24/7 gözetim altında evcil hayvanlarınıza"
                                        " özenli bir şekilde hizmet vermektedir.Otelimizde köpekler ve kediler için ayrı ayrı"
                                        " tasarlanmış konaklama birimleri, özel oyun alanları ve günlük aktiviteler sunulmaktadır."],],
                                    imagePath: 'asset/pictures-2/norfolkT.png',
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  'asset/pictures/norfolkT.png', width: 150,
                                  height: 140,),
                              ),


                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[["Evcil dostlarınıza şımartıcı bir kaçamak"],],
                                    descriptions:[["Evcil dostlarınıza şımartıcı bir kaçamak"
                                     "Paws & Claws Oteli, evcil hayvanınızın tatilini unutulmaz kılmak için lüks konaklama seçenekleri, spa hizmetleri ve eğlenceli aktiviteler sunar."
                                        "Profesyonel veterinerler ve bakım uzmanları, evcil dostlarınızın sağlık ve mutluluğu için özenle ilgilenir."
                                        "Otelimizde evcil hayvanlarınız için özel yüzme havuzları, oyun alanları ve doğa yürüyüş parkurları bulunur."],],
                                    imagePath:  'asset/pictures-2/collie.png',
                                  );
                                  _showCard(context, card);
                                },

                                child: Image.asset(
                                  'asset/pictures/collie.png', width: 150,
                                  height: 140,),
                              ),

                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[["Mutlu anılar için mükemmel tatil mekan"],],
                                    descriptions:[[" Happy Tails Resort, evcil dostlarınızı ağırlarken onlara sevgi, güven ve eğlence dolu bir ortam sunar."
                                        "Geniş ve rahat konaklama birimlerimizde evcil hayvanlarınız kendilerini evlerinde hissedecekler."
                                        "Otelimizde özel yürüyüş parkurları, oyun grupları ve veteriner hizmetleri gibi birçok olanak bulunur. "],],
                                    imagePath: 'asset/pictures-2/goldenR.png',
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  'asset/pictures/goldenR.png', width: 150,
                                  height: 140,),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),),

            Container(width: MediaQuery.of(context).size.width,
              height: 24,
              child:Stack(
                children: [
                  Text(
                    'Kediler', style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Container(
              width: MediaQuery.of(context).size.width -0,
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                      titles:[
                                      ["Ayşe Yılmaz"],
                                      ["Benimle Evcil Hayvanınız Güvende!"],
                                      ],
                                      descriptions:[["Merhaba! Ben hayvan bakıcısı olarak uzun yıllardır hizmet veren biriyim. Evcil hayvanınıza sevgi, ilgi ve güvence sağlamak için buradayım."
                                      ""
                                      "Hizmetlerim:"
                                      "Evde veya evinizde evcil hayvanınıza göz kulak olmak."
                                      "Beslenme, yürüyüş ve egzersiz programı oluşturmak."
                                      "Tuvalet ihtiyaçlarını temizlemek ve hijyenik ortam sağlamak."
                                      "İlaç vermek ve tıbbi bakım sağlamak (gerektiğinde)."
                                      "Oyun oynamak, sevgi dolu etkileşimlerde bulunmak.",],],
                                      imagePath:'asset/pictures-2/chartreux.png',
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  'asset/pictures/chartreux.png', width: 150,
                                  height: 140,),),


                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[
                                      ["Profesyonel Evcil Hayvan Bakıcısı"],
                                      [ "Hizmetlerim:"],
                                    ],
                                    descriptions:[["Merhaba! Hayvansever ve sorumluluk sahibi bir hayvan bakıcısıyım. Evcil hayvanınıza gereken sevgi, ilgi ve bakımı sağlamak için buradayım."],
                                      [ "Günlük beslenme, su değişimi ve tuvalet ihtiyaçlarını karşılamak."
                                          "Yürüyüş, egzersiz ve oyun programı oluşturmak."
                                          "Evcil hayvanınıza ilaç vermek ve tıbbi bakım sağlamak."
                                          "Evde veya evinizde güvenli bir ortam oluşturmak."
                                          "Evcil hayvanınıza sevgi dolu etkileşimlerde bulunmak.",],],
                                    imagePath:'asset/pictures-2/europeanS.png',
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  'asset/pictures/europeanS.png', width: 150,
                                  height: 140,),),


                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[
                                      ["Evcil Hayvan Bakımı için Profesyonel Yardım"],
                                      ["Hizmetlerim:"],
                                    ],
                                    descriptions:[["Merhaba! Hayvansever ve sorumluluk sahibi bir hayvan bakıcısıyım. "
                                        "Evcil hayvanınıza gereken sevgi, ilgi ve bakımı sağlamak için buradayım."],


                                      [ "Günlük beslenme, su değişimi ve tuvalet ihtiyaçlarını karşılamak."
                                          "Yürüyüş, egzersiz ve oyun programı oluşturmak."
                                          "Evcil hayvanınıza ilaç vermek ve tıbbi bakım sağlamak."
                                          "Evde veya evinizde güvenli bir ortam oluşturmak."
                                          "Evcil hayvanınıza sevgi dolu etkileşimlerde bulunmak."],],
                                    imagePath:'asset/pictures-2/scottishF.png',
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  'asset/pictures/scottishF.png', width: 150,
                                  height: 140,),),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),),






            Container(width: MediaQuery.of(context).size.width,
              height: 24,
              child:Stack(
                children: [
                  Text(
                    'Hamstırlar', style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Container(
              width: MediaQuery.of(context).size.width -0,
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[["Tüylü dostlarınızın cenneti!"],],
                                    descriptions:[["Köpek maması, kedi kumu, oyuncaklar, tasma ve tasarım evcil hayvan eşyaları."],],
                                    imagePath:'asset/pictures-2/çinH.png',
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  'asset/pictures/çinH.png', width: 150,
                                  height: 140,),),

                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[["Patilerinize özel bir alışveriş deneyimi!"],],
                                    descriptions:[["Köpek mamaları ve atıştırmalıklar, kedi kumu ve kedi maması, "
                                        "kuş yemleri ve kafesler, akvaryum malzemeleri."],],
                                    imagePath: 'asset/pictures-2/avrupaH.png',
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  'asset/pictures/avrupaH.png', width: 150,
                                  height: 140,),),

                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[["Sevgi dolu evcil hayvanlar için doğru adres!"],],
                                    descriptions:[["Köpek ve kedi mamaları, evcil hayvan oyuncakları,"
                                        " kuş kafesleri, balık tankları ve akvaryum malzemeleri."],],
                                    imagePath:  'asset/pictures-2/gonzalesH.png',
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  'asset/pictures/gonzalesH.png', width: 150,
                                  height: 140,),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),),



            Container(width: MediaQuery.of(context).size.width,
              height: 24,
              child:Stack(
                children: [
                  Text(
                    'Tavşanlar', style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Container(
              width: MediaQuery.of(context).size.width -0,
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[["Patileri şımartan bir dokunuş!"],],
                                    descriptions:[["Köpek ve kedi tımarı, tüy kesimi, yıkanma ve kurutma,"
                                        " tırnak kesimi, kulak temizliği, taraklama ve özel cilt bakımı."],],
                                    imagePath:  "asset/pictures-2/Hothot tavşanı (2).png",
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  "asset/pictures/Hothot tavşanı.png", width: 150,
                                  height: 140,),),

                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[["Kişilik & Karakter Özellikleri"],],
                                    descriptions:[["Tüy kesimi ve şekillendirme, yaratıcı tımar stilleri, renkli tüy boyama, köpük banyolar, tırnak cilalama, göz ve kulak temizliği."],],
                                    imagePath:  'asset/pictures-2/Hollanda Lop tavşanı (2).png',
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  'asset/pictures/Hollanda Lop tavşanı.png', width: 150,
                                  height: 140,),),

                              InkWell(
                                onTap: () {
                                  MyCard card = MyCard(
                                    titles:[["Sağlıklı tüyler, mutlu patiler!"],],
                                    descriptions:[["Tüy kesimi, yıkanma ve kurutma, fırçalama, tırnak bakımı, koku giderme,"
                                        " cilt ve tüy bakımı, spa tedavileri, özel tımar paketleri."],],
                                    imagePath: 'asset/pictures-2/Havana tavşanı (2).png',
                                  );
                                  _showCard(context, card);
                                },
                                child: Image.asset(
                                  'asset/pictures/Havana tavşanı.png', width: 150,
                                  height: 140,),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),),




          ],
        ),
      ),
    );
  }

  List<String> _getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(names);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}