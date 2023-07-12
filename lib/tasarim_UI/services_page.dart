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
  final List<String> titles;
  final List<String> descriptions;
  final String imagePath;

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
                      (index) => Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              card.titles[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            card.descriptions[index],
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),Row(
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
                      titles: ['Evcil dostlarınızın rüya tatili'],
                      descriptions: [
                        "Lüks konaklama birimleri ve geniş açık alanlarla donatılmış olan Pet Paradise Oteli, evcil dostlarınızın unutulmaz bir tatil deneyimi yaşaması için tasarlanmıştır."
"Profesyonel ve sevgi dolu personelimiz, 24/7 gözetim altında evcil hayvanlarınıza özenli bir şekilde hizmet vermektedir."
"Otelimizde köpekler ve kediler için ayrı ayrı tasarlanmış konaklama birimleri, özel oyun alanları ve günlük aktiviteler sunulmaktadır.",
                      ],
                      imagePath: 'asset/pictures-2/norfolkT.png',
                    );
                    _showCard(context, card);
                  }
                  if (suggestion == "Paws & Claws Evcil Hayvan Spa ve Tatil Köyü") {
                    MyCard card = MyCard(
                      titles:["Evcil dostlarınıza şımartıcı bir kaçamak"],
                      descriptions:[ "Paws & Claws Oteli, evcil hayvanınızın tatilini unutulmaz kılmak için lüks konaklama seçenekleri, spa hizmetleri ve eğlenceli aktiviteler sunar."
"Profesyonel veterinerler ve bakım uzmanları, evcil dostlarınızın sağlık ve mutluluğu için özenle ilgilenir."
"Otelimizde evcil hayvanlarınız için özel yüzme havuzları, oyun alanları ve doğa yürüyüş parkurları bulunur.",],
                      imagePath: 'asset/pictures-2/collie.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Happy Tails Evcil Hayvan Resort") {
                    MyCard card = MyCard(
                      titles:["Mutlu anılar için mükemmel tatil mekan",],
                      descriptions:[" Happy Tails Resort, evcil dostlarınızı ağırlarken onlara sevgi, güven ve eğlence dolu bir ortam sunar."
"Geniş ve rahat konaklama birimlerimizde evcil hayvanlarınız kendilerini evlerinde hissedecekler."
"Otelimizde özel yürüyüş parkurları, oyun grupları ve veteriner hizmetleri gibi birçok olanak bulunur. ",],
                      imagePath:  'asset/pictures-2/goldenR.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Ayşe Yılmaz") {
                    MyCard card = MyCard(
                      titles:["Benimle Evcil Hayvanınız Güvende!"],
                      descriptions:["Merhaba! Ben hayvan bakıcısı olarak uzun yıllardır hizmet veren biriyim. Evcil hayvanınıza sevgi, ilgi ve güvence sağlamak için buradayım."
                      ""
                      "Hizmetlerim:"
                      "Evde veya evinizde evcil hayvanınıza göz kulak olmak."
"Beslenme, yürüyüş ve egzersiz programı oluşturmak."
"Tuvalet ihtiyaçlarını temizlemek ve hijyenik ortam sağlamak."
"İlaç vermek ve tıbbi bakım sağlamak (gerektiğinde)."
"Oyun oynamak, sevgi dolu etkileşimlerde bulunmak.",],
                      imagePath:'asset/pictures-2/chartreux.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Ramazan Kaya") {
                    MyCard card = MyCard(
                      titles:["Profesyonel Evcil Hayvan Bakıcısı"],
                      descriptions:["Merhaba! Hayvansever ve sorumluluk sahibi bir hayvan bakıcısıyım. Evcil hayvanınıza gereken sevgi, ilgi ve bakımı sağlamak için buradayım."
                      ""
                      "Hizmetlerim:"
                      "Günlük beslenme, su değişimi ve tuvalet ihtiyaçlarını karşılamak."
"Yürüyüş, egzersiz ve oyun programı oluşturmak."
"Evcil hayvanınıza ilaç vermek ve tıbbi bakım sağlamak."
"Evde veya evinizde güvenli bir ortam oluşturmak."
"Evcil hayvanınıza sevgi dolu etkileşimlerde bulunmak.",],
                      imagePath:'asset/pictures-2/europeanS.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Zaynep Acar") {
                    MyCard card = MyCard(
                      titles:["Evcil Hayvan Bakımı için Profesyonel Yardım"],
                      descriptions:["Merhaba! Hayvansever ve sorumluluk sahibi bir hayvan bakıcısıyım. Evcil hayvanınıza gereken sevgi, ilgi ve bakımı sağlamak için buradayım."
                      ""
                      "Hizmetlerim:"
                      "Günlük beslenme, su değişimi ve tuvalet ihtiyaçlarını karşılamak."
"Yürüyüş, egzersiz ve oyun programı oluşturmak."
"Evcil hayvanınıza ilaç vermek ve tıbbi bakım sağlamak."
"Evde veya evinizde güvenli bir ortam oluşturmak."
"Evcil hayvanınıza sevgi dolu etkileşimlerde bulunmak.",],
                      imagePath:'asset/pictures-2/scottishF.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Evcil Cennet") {
                    MyCard card = MyCard(
                      titles:["Tüylü dostlarınızın cenneti!"],
                      descriptions:["Köpek maması, kedi kumu, oyuncaklar, tasma ve tasarım evcil hayvan eşyaları.",],
                      imagePath:'asset/pictures-2/çinH.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Patili Dükkan") {
                    MyCard card = MyCard(
                      titles:["Patilerinize özel bir alışveriş deneyimi!"],
                      descriptions:["Köpek mamaları ve atıştırmalıklar, kedi kumu ve kedi maması, kuş yemleri ve kafesler, akvaryum malzemeleri.",],
                      imagePath: 'asset/pictures-2/avrupaH.png',
                    );
                    _showCard(context, card);
                  }


                  if (suggestion == "Sevimli Köşe") {
                    MyCard card = MyCard(
                      titles:["Sevgi dolu evcil hayvanlar için doğru adres!"],
                      descriptions:["Köpek ve kedi mamaları, evcil hayvan oyuncakları, kuş kafesleri, balık tankları ve akvaryum malzemeleri.",],
                      imagePath:  'asset/pictures-2/gonzalesH.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Pampered Paws") {
                    MyCard card = MyCard(
                      titles:["Patileri şımartan bir dokunuş!"],
                      descriptions:["Köpek ve kedi tımarı, tüy kesimi, yıkanma ve kurutma, tırnak kesimi, kulak temizliği, taraklama ve özel cilt bakımı.",],
                      imagePath:  "asset/pictures-2/Hothot tavşanı (2).png",
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Furry Styles") {
                    MyCard card = MyCard(
                      titles:["Kişilik & Karakter Özellikleri"],
                      descriptions:[ "Tüy kesimi ve şekillendirme, yaratıcı tımar stilleri, renkli tüy boyama, köpük banyolar, tırnak cilalama, göz ve kulak temizliği.",],
                      imagePath:  'asset/pictures-2/Hollanda Lop tavşanı (2).png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Paws & Co.") {
                    MyCard card = MyCard(
                      titles:["Sağlıklı tüyler, mutlu patiler!"],
                      descriptions:[ "Tüy kesimi, yıkanma ve kurutma, fırçalama, tırnak bakımı, koku giderme, cilt ve tüy bakımı, spa tedavileri, özel tımar paketleri.",],
                      imagePath: 'asset/pictures-2/Havana tavşanı (2).png',
                    );
                    _showCard(context, card);
                  }
                  if (suggestion == "Pawsitive Pups") {
                    MyCard card = MyCard(
                      titles:["Köpeğinizle pozitif bir bağ kurun!"],
                      descriptions:[ "Bazı tavşanlar birçok oyuncakla eğlenmeye ihtiyaç duyarlar "
                          "(bir mağaza satın alınmış mı yoksa tuvalet kağıdı rulosu kadar basit bir şey "
                          "tamamen size bağlıdır), diğerleri onları mutlu etmek için fazla bir şeye ihtiyaç duymaz."
                          " Her biri, evcil hayvanınızın kendi muhafazaları dışında çok sayıda oyun süresiyle "
                          "keşfetmesi gereken tavşanınızın kişiliğine bağlıdır.Bu tavşan eğitim lazım olduğunda,"
                          " bir kedi ya da köpek gibi başka bir evcil hayvan eğitimi daha önemli olduğunu"
                          " görebilirsiniz. Daha zorlu olsa da, tavşanlar eğitmek kesinlikle imkansız değil"
                          " ama diğer hayvanlara göre daha fazla sabır ve zaman gerektiriyorlar. "
                          "Birçok evcil hayvan ailesi, evin etrafına birkaç çöp kutusu yerleştirmenin "
                          "en iyi şekilde işe yaradığını fark etti, çünkü tavşanı yapmak için tavşanınızın "
                          "evinizin diğer tarafına gitmesi gerekmiyor.",],
                      imagePath: 'asset/pictures-2/Havana tavşanı (2).png',
                    );
                    _showCard(context, card);
                  }
                  if (suggestion == "Cannie Academy") {
                    MyCard card = MyCard(
                      titles:["Köpeğinizi eğitirken en iyiyi arayın!"],
                      descriptions:[ "Temel komut eğitimi, problem davranış düzeltme, köpek davranış analizi, sosyalizasyon, çevre uyum eğitimi, terapi köpeği eğitimi.",],
                      imagePath: 'asset/pictures-2/Havana tavşanı (2).png',
                    );
                    _showCard(context, card);
                  }
                  if (suggestion == "Smart Paws Training Center") {
                    MyCard card = MyCard(
                      titles:["Zekice eğitilmiş patiler!"],
                      descriptions:[ "Temel itaat eğitimi, yürüyüş eğitimi, sosyalleşme, problem davranışların düzeltilmesi, ileri itaat eğitimi, köpek sporları eğitimi.",],
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
                                    titles:["Kişilik & Karakter Özellikleri"],
                                    descriptions:[" Norfolk Terrier, alıngan, cesur, meraklı, oyunbaz, kavgacı, sadık, neşeli, canlı, inatçı"
                                        " ve bağımsız karakter özellikleriyle tam bir teriyerdir. Tarlada “iblis” olarak bilinir"
                                        "ve avlanmayı, kazmayı ve Keşfetmeyi sever. Hareketli, bağımsız yapısından dolayı güvenli "
                                        "bir alan tutulması gerekir. Zeki ve dost canlısıdır ancak iradeli bir yapıları ve kendi"
                                        "düşünceleriyle hareket etmek isteyebilirler.",],
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
                                    titles:["Kişilik & Karakter Özellikleri"],
                                    descriptions:[" Colli güçlü, hızlı ve zarif yapının bir araya geldiği aktif ve "
                                        "kıvrak bir köpektir. Collis, Colley, Coally isimleriyle de bilinirler. "
                                        "Nazik, özverili ve yumuşak huylu yapısıyla arkadaş canlısı bir köpektir."
                                        " Yürüyüşleri, gütme köpeklerinde olduğu gibi zahmetsiz ve hızlı yön değiştirme "
                                        "yeteneği ile birleşmektedir. Kürkü hem Smooth hem de Rough çeşidinin yumuşak,"
                                        " bol bir astarlıdır. Smooth türünün dış kaplaması kısa, sert ve düz iken Rough"
                                        " çeşidininki düz, sert, bol ve uzun yapıdadır. ",],
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
                                    titles:["Kişilik & Karakter Özellikleri"],
                                    descriptions:[" Golden Retriever bulunduğu ortamda sevimliliği, cana yakınlığı ve oyunculuğu ile "
                                        "tüm gözleri üzerine çekmektedir. Orta büyüklüğe sahip bu sevimli ırk, "
                                        "açık kahverengi ve krem tonlarındaki yumuşak ve göz alıcı bedeniyle kalpleri kazanır."
                                        " Atletik, ve güçlü bir yapısı vardır. Güçlü ön ve arka ayakları ile karada olduğu gibi"
                                        " suda da hareket etme, avlanma yeteneğine sahiptir. Düz veya dalgalı kabarık kürke"
                                        " sahiptir. Dost canlısı olan Golden Retriever kısa sürede ailenizden birisi olur. ",],
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
                                                  titles:["Kişilik & Karakter Özellikleri"],
                                                  descriptions:[ "Chartreux cinsi kediler özellikle de son dönemlerde en çok "
                                                      "sevilen evcil hayvanlar arasında yer alıyor. Yumuşacık "
                                                      "duman rengi tüyleri ile sahiplenmek isteyenleri anında büyülüyor."
                                                      " Ayrıca ilk bakışta fark edilecek güzellikte olan gözleri ile de"
                                                      " insanları etkisi altına alıyor. Diğer evcil kedilerden farklı olarak "
                                                      "Chartreux cinsleri genel olarak ilgiden hoşlansalar da size kendi "
                                                      "ilgisini ilk başta pek göstermeyecek türde kedilerdir.",],
                                                  imagePath: 'asset/pictures-2/chartreux.png',
                                                );
                                                _showCard(context, card);
                                              },
                                              child: Image.asset(
                                                'asset/pictures/chartreux.png', width: 150,
                                                height: 140,),),


                                            InkWell(
                                              onTap: () {
                                                MyCard card = MyCard(
                                                  titles:["Kişilik & Karakter Özellikleri"],
                                                  descriptions:[ "Onu ilk gördüğünüzde renk ve desenlerinden dolayı Tekir veya Sarman kedisine benzetebilirsiniz."
                                                      " Ancak o kendine has görünümü, mizacı ve davranışlarıyla bir Tekir veya Sarman kedisinden daha fazlasıdır."
                                                      " Tüm kedi ırkları arasında en doğalı olan European Shorthair kedisi, binlerce yıl öncesinde "
                                                      "Romalılar tarafından Avrupa’ya getirilmiş melez bir ırktır.",],
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
                                                  titles:["Kişilik & Karakter Özellikleri"],
                                                  descriptions:["İskoç kırması bu tatlı kediler, İskoçya’daki çiftlik kedilerinin kendiliğinden"
                                                " bir mutasyon sonucu ortaya çıkmış bir cinstir. En belirgin özellikleri "
                                                "kulaklarının katlı olmasıdır. Bu özelliğiyle farklı ve dayanıklı bir görünüme sahip olan"
                                                " Scottish Fold’lar aynı zamanda arkadaş canlısı ve yüksek zekâ seviyesine sahip türde "
                                                      "birer cins kedidirler.",],
                                                  imagePath: 'asset/pictures-2/scottishF.png',
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
                                                  titles:["Kişilik & Karakter Özellikleri"],
                                                  descriptions:["Çin çizgili hamster gerçek cüce hamster değildir, "
                                                      "ancak diğer küçük hamsterlara benzer boyuttadır."
                                                      " Adından da anlaşılacağı gibi, aslında Çin ve Moğolistan'dan."
                                                      " Çin hamsterları yaygın olarak yetiştirilmez, evcil hayvan"
                                                      " mağazalarında bulmak zor olabilir ve ayrıca onları tutmak için bir iznin "
                                                      "gerekli olduğu Kaliforniya eyaleti gibi bazı yerlerde kısıtlıdır.",],
                                                  imagePath: 'asset/pictures-2/çinH.png',
                                                );
                                                _showCard(context, card);
                                              },
                                              child: Image.asset(
                                                'asset/pictures/çinH.png', width: 150,
                                                height: 140,),),

                                            InkWell(
                                              onTap: () {
                                                MyCard card = MyCard(
                                                  titles:["Kişilik & Karakter Özellikleri"],
                                                  descriptions:[ "Avrupa Hamsterı, 30 cm.’lik boyuyla Hamster türlerinin en büyüğüdür."
                                                      " Renk farklılığı ile de diğer türlerden ayrılır. Karın bölgesi siyah,"
                                                      " sırtı kahverengi ve yan bölgeler beyazdır. Doğu Avrupa ve"
                                                      " Batı Asya’da toprağın altında yaşar. Tarım alanlarına büyük zararlar vermesiyle bilinir.",],
                                                  imagePath:  'asset/pictures-2/avrupaH.png',
                                                );
                                                _showCard(context, card);
                                              },
                                              child: Image.asset(
                                                'asset/pictures/avrupaH.png', width: 150,
                                                height: 140,),),

                                            InkWell(
                                              onTap: () {
                                                MyCard card = MyCard(
                                                  titles:["Kişilik & Karakter Özellikleri"],
                                                  descriptions:[ "Gonzales hamster doğada yarı kurak bozkırları mesken edinir."
                                                      " Burada kazdığı yaklaşık 1 metre uzunluğundaki yuvasında yaşar."
                                                      " Yuvasının duvarlarına koyun yünü ve kuru otlarla kaplar. "
                                                      "Bu sayede dışarıdaki hava -25 santigrat derece iken, içindeki sıcaklık "
                                                      "15 santigrat derece civarında olur. Bu sıcaklık gonzales hamsterın yavrularını "
                                                      "yetiştirmesi için ideal değerdir.",],
                                                  imagePath: 'asset/pictures-2/gonzalesH.png',
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
                                    titles:["Kişilik & Karakter Özellikleri"],
                                    descriptions:["Tür genel anlamda arkadaş canlısıdır ve evcil hayvan olarak beslenebilir. "
                                        "Sahiplenilen tavşanın sosyal bir canlı olması için yavruluğundan itibaren insanlarla"
                                        " etkileşim halinde olması gerekir. Günlük ihtiyaçlarının karşılanması için kafesinden"
                                        " çıkartılması iyi bir başlangıç olacaktır. Bu sayede insanlar tarafından tutulmaya alışır. "
                                        "Çocuklar tarafından beslenecekse, onlara tavşanı nasıl tutmaları gerektiği öğretilmelidir.",],
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
                                    titles:["Kişilik & Karakter Özellikleri"],
                                    descriptions:[ "Hollanda lop tavşanınızın karakter gelişimi için, ona kafesinin "
                                  "dışında geçireceği uzun vakitler sağlamanız çok önemlidir. "
                                  "Evde yaşayan tavşanlar evin tamamında olmasa bile en azından bir odasında "
                                    "kafesinden çıkıp etrafta dolaşabilmeli, bacaklarını esnetebilmeli, güneş ışığı almalı"
                                    " ve özellikle sahibi ile etkileşim halinde olabilmelidir. Bu ufak tavşanlar ister yalnız "
                                    "yaşayan bir insan, ister evli bir çift, isterse de çocuklu aileler olsun; herkes için harika"
                                    " evcil hayvanlardır.Hollanda lopları görece aktif tavşanlardır ve hava sıcaklığı uygun "
                                        "olduğunda dışarıda vakit geçirmeye bayılırlar. Etrafı çevrili bir bahçe onlar için"
                                        " harika olacaktır, ancak açık bir bahçede kafes içinde beslenmelidir. "
                                        "Üstü açık, çevresi tel örgüyle çevrili bir kafes hem tavşanınıza biraz özgürlük "
                                        "hissi verecek, hem de komşu bahçelere kaçmasını önleyecektir.",],
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
                                    titles:["Kişilik & Karakter Özellikleri"],
                                    descriptions:[ "Bazı tavşanlar birçok oyuncakla eğlenmeye ihtiyaç duyarlar "
                                  "(bir mağaza satın alınmış mı yoksa tuvalet kağıdı rulosu kadar basit bir şey "
                                  "tamamen size bağlıdır), diğerleri onları mutlu etmek için fazla bir şeye ihtiyaç duymaz."
                                    " Her biri, evcil hayvanınızın kendi muhafazaları dışında çok sayıda oyun süresiyle "
                                    "keşfetmesi gereken tavşanınızın kişiliğine bağlıdır.Bu tavşan eğitim lazım olduğunda,"
                                        " bir kedi ya da köpek gibi başka bir evcil hayvan eğitimi daha önemli olduğunu"
                                        " görebilirsiniz. Daha zorlu olsa da, tavşanlar eğitmek kesinlikle imkansız değil"
                                        " ama diğer hayvanlara göre daha fazla sabır ve zaman gerektiriyorlar. "
                                        "Birçok evcil hayvan ailesi, evin etrafına birkaç çöp kutusu yerleştirmenin "
                                        "en iyi şekilde işe yaradığını fark etti, çünkü tavşanı yapmak için tavşanınızın "
                                        "evinizin diğer tarafına gitmesi gerekmiyor.",],
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

