import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../tasarim_UI/tema.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme:theme(),
      home: HomePage(),
    );
  }
}


class MyCard {
  final List<String> titles;
  final List<String> descriptions;
  final String imagePath;

  MyCard({required this.titles, required this.imagePath, required this.descriptions});
}

class HomePage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final List<String> names = [
    'Norfolk Terrier',
    'Collie',
    'Golden Retriever',
    'Chartreux',
    'European Shorthair',
    'Scottish Fold',
    'Çin Hamster',
    'Avrupa Hamster',
    'Gonzales Hamster',
  ];


  void _showCard(BuildContext context,  MyCard card) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView( // SingleChildScrollView eklendi
          child: AlertDialog(
          content:SingleChildScrollView(
           child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(card.imagePath,
                width: 150,
                height: 140,),// Resim yolunu güncelleyin
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
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Kapat'),
              ),
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
                    hintText: "Hayvan Ara",
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
                  if (suggestion == "Norfolk Terrier") {
                    MyCard card = MyCard(
                      titles:[ 'Kişilik & Karakter Özellikleri'],
                      descriptions: [ "Norfolk Terrier, alıngan, cesur, meraklı, oyunbaz, kavgacı, sadık, neşeli, canlı,"
                          " inatçı ve bağımsız karakter özellikleriyle tam bir teriyerdir. Tarlada “iblis” olarak bilinir "
                          "ve avlanmayı, kazmayı ve keşfetmeyi sever. Hareketli, bağımsız yapısından dolayı güvenli bir "
                          "alan tutulması gerekir. Zeki ve dost canlısıdır ancak iradeli bir yapıları ve kendi düşünceleriyle "
                          "hareket etmek isteyebilirler.",],

                      imagePath: 'asset/pictures-2/norfolkT.png',
                    );
                    _showCard(context, card);
                  }
                  if (suggestion == "Collie") {
                    MyCard card = MyCard(
                      titles:["Kişilik & Karakter Özellikleri"],
                      descriptions:[ "Collie zeki, tatlı, canlı, uysal, hassas, yumuşak huylu,"
                          "uyumlu ve arkadaş canlısı bir köpektir. Collie sahibine sadık,"
                      "eğitilmesi kolay ve itaatkar bir ırktır. Genellikle diğer evcil "
                          "hayvanlarla ve diğer köpeklerle de arası iyi, arkadaş canlısıdır. "
                          "Çocukları çok sever, çocuklarla oyun oynamaktan mutlu olurlar ve "
                          "çocukları çevresindeki olumsuzluklara karşı korumak isterler. "
                          "İyi yetiştirilmiş, eğitilmiş bir Collie köpeğinin oldukça arkadaş canlısı "
                          "ve uysal olduğu gözlemlenmektedir. Collie karakter yapısıyla tam bir"
                          " aile köpeğidir ve tüm ailenin vazgeçilmez bir parçası olmaktan çok mutlu olur.",],
                      imagePath: 'asset/pictures-2/collie.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Golden Retriever") {
                    MyCard card = MyCard(
                      titles:["Kişilik & Karakter Özellikleri",],
                      descriptions:[" Golden Retriever bulunduğu ortamda sevimliliği, cana yakınlığı ve oyunculuğu ile "
                          "tüm gözleri üzerine çekmektedir. Orta büyüklüğe sahip bu sevimli ırk, "
                          "açık kahverengi ve krem tonlarındaki yumuşak ve göz alıcı bedeniyle kalpleri kazanır."
                          " Atletik, ve güçlü bir yapısı vardır. Güçlü ön ve arka ayakları ile karada olduğu gibi"
                          " suda da hareket etme, avlanma yeteneğine sahiptir. Düz veya dalgalı kabarık kürke"
                          " sahiptir. Dost canlısı olan Golden Retriever kısa sürede ailenizden birisi olur. ",],
                      imagePath:  'asset/pictures-2/goldenR.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Chartreux") {
                    MyCard card = MyCard(
                      titles:["Kişilik & Karakter Özellikleri"],
                      descriptions:["Chartreux cinsi kediler özellikle de son dönemlerde en çok "
                          "sevilen evcil hayvanlar arasında yer alıyor. Yumuşacık "
                          "duman rengi tüyleri ile sahiplenmek isteyenleri anında büyülüyor."
                          " Ayrıca ilk bakışta fark edilecek güzellikte olan gözleri ile de"
                          " insanları etkisi altına alıyor. Diğer evcil kedilerden farklı olarak "
                          "Chartreux cinsleri genel olarak ilgiden hoşlansalar da size kendi "
                          "ilgisini ilk başta pek göstermeyecek türde kedilerdir.",],
                      imagePath:'asset/pictures-2/chartreux.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "European Shorthair") {
                    MyCard card = MyCard(
                      titles:["Kişilik & Karakter Özellikleri"],
                      descriptions:["Onu ilk gördüğünüzde renk ve desenlerinden dolayı Tekir veya Sarman kedisine benzetebilirsiniz."
                          " Ancak o kendine has görünümü, mizacı ve davranışlarıyla bir Tekir veya Sarman kedisinden daha fazlasıdır."
                          " Tüm kedi ırkları arasında en doğalı olan European Shorthair kedisi, binlerce yıl öncesinde "
                          "Romalılar tarafından Avrupa’ya getirilmiş melez bir ırktır.",],
                      imagePath:'asset/pictures-2/europeanS.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Scottish Fold") {
                    MyCard card = MyCard(
                      titles:["Kişilik & Karakter Özellikleri"],
                      descriptions: ["İskoç kırması bu tatlı kediler, İskoçya’daki çiftlik kedilerinin kendiliğinden"
                          " bir mutasyon sonucu ortaya çıkmış bir cinstir. En belirgin özellikleri "
                          "kulaklarının katlı olmasıdır. Bu özelliğiyle farklı ve dayanıklı bir görünüme sahip olan"
                          " Scottish Fold’lar aynı zamanda arkadaş canlısı ve yüksek zekâ seviyesine sahip türde birer cins kedidirler.",],
                      imagePath:'asset/pictures-2/scottishF.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Çin Hamster") {
                    MyCard card = MyCard(
                      titles:["Kişilik & Karakter Özellikleri"],
                      descriptions:["Çin çizgili hamster gerçek cüce hamster değildir, "
                          "ancak diğer küçük hamsterlara benzer boyuttadır."
                          " Adından da anlaşılacağı gibi, aslında Çin ve Moğolistan'dan."
                          " Çin hamsterları yaygın olarak yetiştirilmez, evcil hayvan"
                          " mağazalarında bulmak zor olabilir ve ayrıca onları tutmak için bir iznin "
                          "gerekli olduğu Kaliforniya eyaleti gibi bazı yerlerde kısıtlıdır.",],
                      imagePath:'asset/pictures-2/çinH.png',
                    );
                    _showCard(context, card);
                  }

                  if (suggestion == "Avrupa Hamster") {
                    MyCard card = MyCard(
                      titles:["Kişilik & Karakter Özellikleri"],
                      descriptions:["Avrupa Hamsterı, 30 cm.’lik boyuyla Hamster türlerinin en büyüğüdür."
                          " Renk farklılığı ile de diğer türlerden ayrılır. Karın bölgesi siyah,"
                          " sırtı kahverengi ve yan bölgeler beyazdır. Doğu Avrupa ve"
                          " Batı Asya’da toprağın altında yaşar. Tarım alanlarına büyük zararlar vermesiyle bilinir.",],
                      imagePath: 'asset/pictures-2/avrupaH.png',
                    );
                    _showCard(context, card);
                  }


                  if (suggestion == "Gonzales Hamster") {
                    MyCard card = MyCard(
                      titles:["Kişilik & Karakter Özellikleri"],
                      descriptions:["Gonzales hamster doğada yarı kurak bozkırları mesken edinir."
                          " Burada kazdığı yaklaşık 1 metre uzunluğundaki yuvasında yaşar."
                          " Yuvasının duvarlarına koyun yünü ve kuru otlarla kaplar. "
                          "Bu sayede dışarıdaki hava -25 santigrat derece iken, içindeki sıcaklık "
                          "15 santigrat derece civarında olur. Bu sıcaklık gonzales hamsterın yavrularını "
                          "yetiştirmesi için ideal değerdir.",],
                      imagePath:  'asset/pictures-2/gonzalesH.png',
                    );
                    _showCard(context, card);
                  }

                },
              ),

            ),
          ),
        ),
      ),
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

