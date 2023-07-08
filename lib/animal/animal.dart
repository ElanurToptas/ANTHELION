import 'package:flutter/material.dart';
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


class DetailScreen extends StatelessWidget {
  final String image;
  final String text;

  const DetailScreen({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Expanded(
            child:ListView(
              scrollDirection: Axis. vertical,
              children: [
                Container(
                  height: 500,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Roboto-Bold",
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Buton extends StatefulWidget{
  @override
  _ButonState createState() => _ButonState();
}

class _ButonState extends State<Buton>{

  Widget build(BuildContext context) {
    return  Stack(
      children: <Widget> [
        Container (
          padding: EdgeInsets.only(left:5,right:5, top:50),
        width: MediaQuery.of(context).size.width,
          height: 150,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children:<Widget>[
              TextField(
                style: TextStyle(color: Colors.black, fontSize: 28),
                decoration: new InputDecoration.collapsed(hintText: "Animals...", hintStyle: TextStyle(fontSize: 28),),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ],
    );
  }}


class HomePage extends StatelessWidget{
@override
  Widget build (BuildContext context) {
   return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Buton(),
        // Temadan çekilen AppBar rengi
        //title: Text("Hayvanlar"),
      ),
      body: SingleChildScrollView(
        child:Column(
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
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/norfolkT.png',
                                          text: " Norfolk Terrier, alıngan, cesur, meraklı, oyunbaz, kavgacı, sadık, neşeli, canlı, inatçı"
                                              " ve bağımsız karakter özellikleriyle tam bir teriyerdir. Tarlada “iblis” olarak bilinir"
                                              "ve avlanmayı, kazmayı ve Keşfetmeyi sever. Hareketli, bağımsız yapısından dolayı güvenli "
                                              "bir alan tutulması gerekir. Zeki ve dost canlısıdır ancak iradeli bir yapıları ve kendi"
                                              "düşünceleriyle hareket etmek isteyebilirler.",
                                        ),),);
                                },
                                child: Image.asset(
                                  'asset/pictures/norfolkT.png', width: 150,
                                  height: 140,),
                              ),


                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/collie.png',
                                          text: " Colli güçlü, hızlı ve zarif yapının bir araya geldiği aktif ve "
                                              "kıvrak bir köpektir. Collis, Colley, Coally isimleriyle de bilinirler. "
                                              "Nazik, özverili ve yumuşak huylu yapısıyla arkadaş canlısı bir köpektir."
                                              " Yürüyüşleri, gütme köpeklerinde olduğu gibi zahmetsiz ve hızlı yön değiştirme "
                                              "yeteneği ile birleşmektedir. Kürkü hem Smooth hem de Rough çeşidinin yumuşak,"
                                              " bol bir astarlıdır. Smooth türünün dış kaplaması kısa, sert ve düz iken Rough"
                                              " çeşidininki düz, sert, bol ve uzun yapıdadır. Collie ırkının önemli bir ayırt "
                                              "edici özelliği de yelesi ve tüyleridir. Karakter yapısı ve alacağı eğitimlerle iyi "
                                              "bir aile köpeği olacaktır. Collie popülerliğiyle birlikte, dünyanın en çok tanınan"
                                              " ve sevilen köpek ırkları arasında yer almaktadır.",
                                        ),),);
                                },

                                child: Image.asset(
                                  'asset/pictures/collie.png', width: 150,
                                  height: 140,),
                              ),

                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/goldenR.png',
                                          text: " Golden Retriever bulunduğu ortamda sevimliliği, cana yakınlığı ve oyunculuğu ile "
                                              "tüm gözleri üzerine çekmektedir. Orta büyüklüğe sahip bu sevimli ırk, "
                                              "açık kahverengi ve krem tonlarındaki yumuşak ve göz alıcı bedeniyle kalpleri kazanır."
                                              " Atletik, ve güçlü bir yapısı vardır. Güçlü ön ve arka ayakları ile karada olduğu gibi"
                                              " suda da hareket etme, avlanma yeteneğine sahiptir. Düz veya dalgalı kabarık kürke"
                                              " sahiptir. Dost canlısı olan Golden Retriever kısa sürede ailenizden birisi olur. "
                                              "Akıllı ve komutları uygulayabilen bir cins oldukları için eğitim süreci gösterilen"
                                              " düzene bağlı olarak kısa sürede tamamlanabilir. Aile üyeleri ile zaman geçirmekten"
                                              " hoşlanırlar ve sahibini memnun etmeye istekli tavırlar sergilerler. Golden Retriever"
                                              " ırkı sevilmeye ve sevgilerini göstermeye bayılır.",
                                        ),),);
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
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/chartreux.png',
                                          text: "Chartreux cinsi kediler özellikle de son dönemlerde en çok "
                                              "sevilen evcil hayvanlar arasında yer alıyor. Yumuşacık "
                                              "duman rengi tüyleri ile sahiplenmek isteyenleri anında büyülüyor."
                                              " Ayrıca ilk bakışta fark edilecek güzellikte olan gözleri ile de"
                                              " insanları etkisi altına alıyor. Diğer evcil kedilerden farklı olarak "
                                              "Chartreux cinsleri genel olarak ilgiden hoşlansalar da size kendi "
                                              "ilgisini ilk başta pek göstermeyecek türde kedilerdir. Yine de evcil hayvan"
                                              " edinmek ve evinizi şenlendirmek istiyorsanız tercihinizi tatlı mı tatlı bir "
                                              "Chartreux cinsinden yana yapabilirsiniz.",
                                        ),),);
                                },
                                child: Image.asset(
                                  'asset/pictures/chartreux.png', width: 150,
                                  height: 140,),),


                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/europeanS.png',
                                          text: "Onu ilk gördüğünüzde renk ve desenlerinden dolayı Tekir veya Sarman kedisine benzetebilirsiniz."
                                              " Ancak o kendine has görünümü, mizacı ve davranışlarıyla bir Tekir veya Sarman kedisinden daha fazlasıdır."
                                              " Tüm kedi ırkları arasında en doğalı olan European Shorthair kedisi, binlerce yıl öncesinde "
                                              "Romalılar tarafından Avrupa’ya getirilmiş melez bir ırktır. European Shorthair kedisinin mizacı, kökeni ve"
                                              " daha fazlası hakkında bilgiyi yazımızın devamında bulabilirsiniz.",
                                        ),),);
                                },
                                child: Image.asset(
                                  'asset/pictures/europeanS.png', width: 150,
                                  height: 140,),),


                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/scottishF.png',
                                          text: "İskoç kırması bu tatlı kediler, İskoçya’daki çiftlik kedilerinin kendiliğinden"
                                              " bir mutasyon sonucu ortaya çıkmış bir cinstir. En belirgin özellikleri "
                                              "kulaklarının katlı olmasıdır. Bu özelliğiyle farklı ve dayanıklı bir görünüme sahip olan"
                                              " Scottish Fold’lar aynı zamanda arkadaş canlısı ve yüksek zekâ seviyesine sahip türde birer cins kedidirler.",
                                        ),),);
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
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/çinH.png',
                                          text: "Çin çizgili hamster gerçek cüce hamster değildir, "
                                              "ancak diğer küçük hamsterlara benzer boyuttadır."
                                              " Adından da anlaşılacağı gibi, aslında Çin ve Moğolistan'dan."
                                              " Çin hamsterları yaygın olarak yetiştirilmez, evcil hayvan"
                                              " mağazalarında bulmak zor olabilir ve ayrıca onları tutmak için bir iznin "
                                              "gerekli olduğu Kaliforniya eyaleti gibi bazı yerlerde kısıtlıdır.",
                                        ),),);
                                },
                                child: Image.asset(
                                  'asset/pictures/çinH.png', width: 150,
                                  height: 140,),),

                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/avrupaH.png',
                                          text: "Avrupa Hamsterı, 30 cm.’lik boyuyla Hamster türlerinin en büyüğüdür."
                                              " Renk farklılığı ile de diğer türlerden ayrılır. Karın bölgesi siyah,"
                                              " sırtı kahverengi ve yan bölgeler beyazdır. Doğu Avrupa ve"
                                              " Batı Asya’da toprağın altında yaşar. Tarım alanlarına büyük zararlar vermesiyle bilinir.",
                                        ),),);
                                },
                                child: Image.asset(
                                  'asset/pictures/avrupaH.png', width: 150,
                                  height: 140,),),

                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/gonzalesH.png',
                                          text: "Gonzales hamster doğada yarı kurak bozkırları mesken edinir."
                                              " Burada kazdığı yaklaşık 1 metre uzunluğundaki yuvasında yaşar."
                                              " Yuvasının duvarlarına koyun yünü ve kuru otlarla kaplar. "
                                              "Bu sayede dışarıdaki hava -25 santigrat derece iken, içindeki sıcaklık "
                                              "15 santigrat derece civarında olur. Bu sıcaklık gonzales hamsterın yavrularını "
                                              "yetiştirmesi için ideal değerdir.",
                                        ),),);
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
                  'Kuşlar', style: TextStyle(color: Colors.black, fontSize: 20),
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
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/MuhabbetK.png',
                                          text: "Doğada büyük sürüler halinde yaşamaya alışkın olan bu canlılar oldukça sosyal varlıklardır. "
                                              "Ancak günümüzde muhabbet kuşlarını yabani ortamdan ziyade evlerde kafeslerde görmekteyiz."
                                              "  Genel olarak evcilleştirilmeye müsait olan bu kuş türleri bir kafes içerisinde beslenildiğinde "
                                              "eğitim için de çok uygundurlar. Muhabbet kuşları  birçok ailenin evinde bulunan, sevimli, cana yakın,"
                                              " rengârenk kuşlardır. Bulundukları ortama hareketlilik ve renk getirirler",
                                        ),),);
                                },
                                child: Image.asset(
                                  'asset/pictures/MuhabbetK.png', width: 150,
                                  height: 140,),),

                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/SultanP.png',
                                          text: "Sultan papağanı çok popüler ve insan sever bir süs kuşudur ki çok hayranlari"
                                              "dünya üzerinde kendine celb etmiş. çoğu yetiştiriciler bazı yöntemleri ve"
                                              " teknikleri öğrenerek pahalı papağanı Jako gibi yetiştirmeye başlamışlar."
                                              " Bazıları bir çift sağlıklı ve güzel papağan yetiştirme ile heyecanlı yetiştirme "
                                              "papağan dünyasına giriyorlar ve bazılarıda devasa ve majör hududunda bü sevimli papağanı yetiştiriyorlar.",
                                        ),),);
                                },
                                child: Image.asset(
                                  'asset/pictures/SultanP.png', width: 150,
                                  height: 140,),),

                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(
                                          image: 'asset/pictures/KırmızıAraraunaP.png',
                                          text: "Papağanlar sınıfının en çok tercih edilen ve en çok beğenilen türleri arasında "
                                              "ara papağanları ilk sırada yer almaktadır. Ara papağanları aynı zamanda "
                                              "macaw papağanı olarakta bilinmektedir. Bu papağanların anavatanı Güney Amerika kıtasıdır."
                                              "Güney Amerika kıtasında yaygın olarak bulunurlar. Gösterişli ve rengarenk papağan türleridir."
                                              "Boyları ise ortalama 35-40 cm’den başlamakta ve 90 cm’ye kadar çıkabilmektedir. Birçok alt türü vardır.",
                                        ),),);
                                },
                                child: Image.asset(
                                  'asset/pictures/KırmızıAraraunaP.png',
                                  width: 150, height: 140,),),
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
}