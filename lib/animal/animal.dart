import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../tasarim_UI/tema.dart';

const SizedBox _sizedBoxHeight10 = SizedBox(height: 10);

class MyApp extends StatelessWidget{
  const MyApp({super.key});

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
    "Hothot Tavşanı",
    "Hollanda Lop Tavşanı",
    "Havana Tavşanı",
  ];


  final List<MyCard> myCards = [
    MyCard(
      titles: ['Kişilik & Karakter Özellikleri',"----------------------------" ,"Sağlık Durumu","Luxating patella", "Kalıtsal göz sorunları","Hipotiroidizm","Allerjiler","Diş sağlığı sorunları"],
      descriptions: [
        "Norfolk Terrier, alıngan, cesur, meraklı, oyunbaz, kavgacı, sadık, neşeli, canlı, inatçı ve bağımsız karakter özellikleriyle tam bir teriyerdir. Tarlada “iblis” olarak bilinir ve avlanmayı, kazmayı ve keşfetmeyi sever. Hareketli, bağımsız yapısından dolayı güvenli bir alan tutulması gerekir. Zeki ve dost canlısıdır ancak iradeli bir yapıları ve kendi düşünceleriyle hareket etmek isteyebilirler.",
      "",
     "Norfolk Terrier, genel olarak sağlıklı bir köpek ırkıdır. Ancak, her köpek gibi bazı sağlık sorunlarıyla karşılaşabilirler. İşte Norfolk Terrier'ın sağlık durumuyla ilgili bazı önemli noktalar:",
         "Luxating patella: Norfolk Terrier'lar arasında sıkça görülen bir sağlık sorunu olan luxating patella, diz ekleminde bir kayma veya çıkık olması durumunu ifade eder. Bu durum köpeğin zorlukla yürümesine ve ağrıya neden olabilir.",

       "Kalıtsal göz sorunları Norfolk Terrier'lar bazı kalıtsal göz sorunlarına yatkın olabilirler. Özellikle katarakt, retinal displazi ve glokom gibi sorunlar gözlenebilir. Düzenli göz kontrolleri bu sorunların erken teşhis edilmesine yardımcı olur.",

        "Hipotiroidizm Norfolk Terrier'lar, tiroid bezinin düşük aktivitesi olarak bilinen hipotiroidizm sorunuyla karşılaşabilirler. Bu durumda metabolizma yavaşlar ve köpeklerde kilo alımı, yorgunluk, cilt sorunları gibi belirtiler ortaya çıkabilir.",

        "Allerjiler Norfolk Terrier'lar, çevresel faktörlere veya yiyeceklere karşı allerjik reaksiyonlar geliştirebilirler. Cilt kaşıntısı, kızarıklık, döküntüler gibi belirtiler görülebilir. Doğru beslenme ve uygun ortam koşulları sağlanarak allerjilerin kontrol altında tutulması önemlidir.",

       "Diş sağlığı sorunları Norfolk Terrier'lar, diş taşı oluşumu ve diş eti hastalıklarına yatkın olabilirler. Düzenli diş temizliği ve veteriner kontrolü bu sorunların önlenmesinde önemlidir.",
      ],
      imagePath: 'asset/pictures-2/norfolkT.png',
    ),
    MyCard(
      titles: ["Kişilik & Karakter Özellikleri","----------------------------" ,"Sağlık Durumu","Göz sorunları","Hip displaz","Dermatomiyozit","Epilepsi","Sindirim sorunları","Kalp sorunları"],
      descriptions: [
        "Collie zeki, tatlı, canlı, uysal, hassas, yumuşak huylu, uyumlu ve arkadaş canlısı bir köpektir. Collie sahibine sadık, eğitilmesi kolay ve itaatkar bir ırktır. Genellikle diğer evcil hayvanlarla ve diğer köpeklerle de arası iyi, arkadaş canlısıdır. Çocukları çok sever, çocuklarla oyun oynamaktan mutlu olurlar ve çocukları çevresindeki olumsuzluklara karşı korumak isterler. "
            "İyi yetiştirilmiş, eğitilmiş bir Collie köpeğinin oldukça arkadaş canlısı ve uysal olduğu gözlemlenmektedir. Collie karakter yapısıyla tam bir aile köpeğidir ve tüm ailenin vazgeçilmez bir parçası olmaktan çok mutlu olur.",
        "",
        "Collie, genel olarak sağlıklı bir köpek ırkıdır. Ancak, bazı genetik ve ırksal sağlık sorunlarına yatkın olabilirler. İşte Collie'nin sağlık durumuyla ilgili bazı önemli noktalar:",
        "Collie'ler, göz sorunlarına yatkın bir ırktır. Özellikle göz yapısı nedeniyle glokom, retinal displazi ve katarakt gibi sorunlar görülebilir. Düzenli göz kontrolleri bu sorunların erken teşhis edilmesine yardımcı olur.",
        "Collie'lerde kalça displazisi, kalça eklemi bozukluğuna işaret eder. Bu durumda kalça ekleminde ağrı, yürüme zorluğu ve sakatlık görülebilir. Düzenli veteriner kontrolleri ve uygun egzersiz yönetimi önemlidir.",
        "Collie'lerde görülen genetik bir cilt ve kas hastalığı olan dermatomiyozit, ciltte yara, döküntü ve kas zayıflığına neden olabilir. Erken teşhis ve tedavi önemlidir.",
        "Collie'lerde epilepsi gibi nörolojik bozukluklar görülebilir. Krizler, bilinç kaybı ve kasılma gibi belirtiler gözlenebilir. Uygun veteriner takibi ve tedavi yönetimi önemlidir.",
        "Bazı Collie'lerde sindirim sorunları, özellikle hassas bir sindirim sistemine sahip olabilirler. Düzenli beslenme, uygun diyet ve besin takviyeleri bu sorunların yönetiminde yardımcı olabilir.",
        "Collie'lerde kalp hastalıkları, özellikle mitral kapak prolapsusu gibi durumlar görülebilir. Düzenli veteriner kontrolleri ve uygun tedavi yönetimi önemlidir.",
      ],
      imagePath: 'asset/pictures-2/collie.png',
    ),
    MyCard(
      titles: ["Kişilik & Karakter Özellikleri","----------------------------","Sağlık Durumu","Kalça displazisi","Diz sorunlar","Cilt sorunları","Göz sorunları","Kanser","Kalp sorunları"],
      descriptions: [
        "Golden Retriever bulunduğu ortamda sevimliliği, cana yakınlığı ve oyunculuğu ile tüm gözleri üzerine çekmektedir. Orta büyüklüğe sahip bu sevimli ırk, açık kahverengi ve krem tonlarındaki yumuşak ve göz alıcı bedeniyle kalpleri kazanır. Atletik ve güçlü bir yapısı vardır. Güçlü ön ve arka ayakları ile karada olduğu gibi suda da hareket etme ve avlanma yeteneğine sahiptir. Düz veya dalgalı kabarık kürke sahiptir. Dost canlısı olan Golden Retriever kısa sürede ailenizden birisi olur.",
        "",
        "Golden Retriever, genel olarak sağlıklı ve dayanıklı bir köpek ırkıdır. Ancak, bazı genetik yatkınlıkları ve ırksal sağlık sorunları bulunabilir. İşte Golden Retriever'ın sağlık durumuyla ilgili bazı önemli bilgiler:",
        "Golden Retriever'lar arasında yaygın olan bir sorun olan kalça displazisi, kalça eklemi bozukluğuna işaret eder. Düzenli veteriner kontrolleri ve kalça displazisine yatkınlığı olan köpeklerde genetik testlerle erken teşhis önemlidir.",
        "Patella çıkığı (luxating patella) ve ön çapraz bağ yaralanmaları gibi diz sorunları Golden Retriever'lar arasında sıkça görülebilir. Bu tür sorunlar köpeğin hareketliliğini etkileyebilir ve cerrahi müdahale gerektirebilir.",
        "Golden Retriever'lar, alerjik dermatit ve kulak enfeksiyonları gibi cilt sorunlarına yatkın olabilirler. Düzenli temizlik ve bakım, cilt sorunlarının önlenmesinde önemlidir. Ayrıca, uygun diyet ve alerjenlere karşı hassaslık kontrolü yapılması da önemlidir.",
        "Katarakt, retinal displazi ve göz enfeksiyonları gibi göz sorunları Golden Retriever'lar arasında görülebilir. Düzenli göz kontrolleri ve erken teşhis önemlidir.",
        "Golden Retriever'lar, kansere yatkın bir ırktır. Özellikle lenfoma ve kanser gibi çeşitli türler görülebilir. Erken teşhis, düzenli veteriner kontrolleri ve kanserle mücadelede uygun tedavi yöntemleri önemlidir.",
        "Dilate kardiyomiyopati gibi kalp sorunları, Golden Retriever'lar arasında görülebilir. Düzenli veteriner kontrolleri ve uygun tedavi yönetimi önemlidir.",
      ],
      imagePath: 'asset/pictures-2/goldenR.png',
    ),
      MyCard(
  titles:["Kişilik & Karakter Özellikleri","----------------------------","Sağlık Durumu","Hipertrofik Kardiyomiyopati (HCM)","Polikistik Böbrek Hastalığı","Diş Problemleri","Obezite"],
  descriptions:["Chartreux cinsi kediler özellikle de son dönemlerde en çok "
  "sevilen evcil hayvanlar arasında yer alıyor. Yumuşacık "
  "duman rengi tüyleri ile sahiplenmek isteyenleri anında büyülüyor."
  " Ayrıca ilk bakışta fark edilecek güzellikte olan gözleri ile de"
  " insanları etkisi altına alıyor. Diğer evcil kedilerden farklı olarak "
  "Chartreux cinsleri genel olarak ilgiden hoşlansalar da size kendi "
  "ilgisini ilk başta pek göstermeyecek türde kedilerdir.",
    "",
    "Chartreux kedileri genellikle sağlıklı ve dayanıklı kedilerdir. Ancak, her türün olduğu gibi bazı genetik sağlık sorunları veya hastalıklarla karşılaşabilirler."
        " Kedilerin sağlık durumu, genetik yatkınlıklar, yaşam tarzı, beslenme ve çevresel faktörlere bağlı olarak değişebilir.",
    " Kalp kasının kalınlaşmasıyla karakterize edilen bir kalp hastalığıdır. Irksal olarak bazı kedilerde daha yaygın olabilir.",
    "Böbreklerde sıvı dolu kistlerin oluştuğu bir durumdur. Bazı kedilerde genetik olarak görülebilir.",
    "Kedilerde diş taşı birikimi, diş eti hastalıkları ve diğer diş sorunları yaygın olabilir. Düzenli diş bakımı bu tür sorunların önlenmesine yardımcı olabilir.",
    "Kısırlaştırılmış veya kısırlaştırılmamış kedilerde obezite eğilimi olabilir. Sağlıklı bir diyet ve düzenli egzersiz, ideal vücut ağırlığını korumalarına yardımcı olur.",],
  imagePath:'asset/pictures-2/chartreux.png',
  ),

  MyCard(
  titles:["Kişilik & Karakter Özellikleri","----------------------------","Sağlık Durumu","Feline Üst Solunum Yolu Enfeksiyonlar","Sindirim Problemleri","Diş Sorunları","Kardiyomiyopati"],
  descriptions:["Onu ilk gördüğünüzde renk ve desenlerinden dolayı Tekir veya Sarman kedisine benzetebilirsiniz."
  " Ancak o kendine has görünümü, mizacı ve davranışlarıyla bir Tekir veya Sarman kedisinden daha fazlasıdır."
  " Tüm kedi ırkları arasında en doğalı olan European Shorthair kedisi, binlerce yıl öncesinde "
  "Romalılar tarafından Avrupa’ya getirilmiş melez bir ırktır.",
    "",
    "Avrupa Kırmızısı (European Shorthair), doğal olarak ortaya çıkan ve kökeni Avrupa'ya dayanan bir kedidir."
        " Diğer kedi ırklarına göre daha az tanınır, ancak sağlıklı ve dayanıklı bir kedi türü olarak bilinir. Bu nedenle, çoğunlukla genetik sağlık sorunlarına yatkınlığı düşük olabilir.",
    "Virüsler veya bakteriler nedeniyle solunum yollarını etkileyen yaygın bir hastalıktır.",
    "Kusma ve ishal gibi sindirim rahatsızlıkları bazı kedi ırklarında görülebilir ve Avrupa Kırmızısı bu durumdan muaf değildir.",
    "Kedilerde diş taşı birikimi, diş eti hastalıkları ve diğer diş problemleri yaşlanma süreciyle birlikte ortaya çıkabilir.",
    "Kalp hastalığı, bazı kedilerde genetik olarak görülebilir ve Avrupa Kırmızısı bu türden etkilenebilir.",],
  imagePath:'asset/pictures-2/europeanS.png',
  ),
  MyCard(
  titles:["Kişilik & Karakter Özellikleri","----------------------------","Sağlık Durumu","Kıkırdak Sorunları", "Osteokondrodisplazi", "Polikistik Böbrek Hastalığı", "Diş Problemleri",],
  descriptions: ["İskoç kırması bu tatlı kediler, İskoçya’daki çiftlik kedilerinin kendiliğinden"
  " bir mutasyon sonucu ortaya çıkmış bir cinstir. En belirgin özellikleri "
  "kulaklarının katlı olmasıdır. Bu özelliğiyle farklı ve dayanıklı bir görünüme sahip olan"
  " Scottish Fold’lar aynı zamanda arkadaş canlısı ve yüksek zekâ seviyesine sahip türde birer cins kedidirler.",
    "",
    "İskoç Kısa Tüylü (Scottish Fold) kedileri, genellikle sağlıklı ve dayanıklı kediler olarak bilinir."
        "Bu türün en belirgin özelliği, kulaklarının uçlarındaki kıkırdakların katlanması nedeniyle kulaklarının aşağı doğru katlanmış görünümüdür. "
        "Ancak, bu genetik özellikleri bazı sağlık sorunlarına yatkınlığı da beraberinde getirebilir.",
    " Kulak katlaması, bazı Scottish Fold kedilerinde kıkırdak ve eklem sorunlarına neden olabilir. Bu, yaşam kalitesini etkileyebilecek eklem sertleşmesi veya ağrısına yol açabilir.",
    " Bu durum, kıkırdak ve kemik gelişimine etki ederek eklemlerde ağrı ve hareket kısıtlılığına neden olabilir.",
    "Bazı Scottish Fold kedileri, böbreklerde kistlerin oluştuğu polikistik böbrek hastalığına yatkın olabilir.",
    " Kedilerde yaygın olarak görülen diş taşı birikimi, diş eti rahatsızlıkları ve diğer diş sorunları Scottish Fold kedilerini de etkileyebilir.",],
  imagePath:'asset/pictures-2/scottishF.png',
  ),

  MyCard(
  titles:["Kişilik & Karakter Özellikleri","----------------------------","Sağlık Durumu","Sindirim Problemleri","Solunum Yolu Enfeksiyonları","Cilt Problemleri","Polikistik Böbrek Hastalığı","Diş Problemleri","Osteokondrodisplazi",],
  descriptions:["Çin çizgili hamster gerçek cüce hamster değildir, "
  "ancak diğer küçük hamsterlara benzer boyuttadır."
  " Adından da anlaşılacağı gibi, aslında Çin ve Moğolistan'dan."
  " Çin hamsterları yaygın olarak yetiştirilmez, evcil hayvan"
  " mağazalarında bulmak zor olabilir ve ayrıca onları tutmak için bir iznin "
  "gerekli olduğu Kaliforniya eyaleti gibi bazı yerlerde kısıtlıdır.",
    "",
    "Çin hamsterları, genellikle sağlıklı ve dayanıklı kemirgenlerdir."
        " Ancak, tüm evcil hayvanlar gibi, onların da sağlıklarını korumak için özenli bir bakıma ve dikkatli bir gözlemeye ihtiyaçları vardır. ",
    "Çin hamsterları bazen kabızlık veya ishal yaşayabilir. Yanlış beslenme, kirli içme suyu ve stres gibi faktörler sindirim sorunlarına neden olabilir.",
    "Soğuk ve nemli ortamlarda tutulduklarında veya maruz kaldıklarında, solunum yolu enfeksiyonları gelişebilir. Hapşırma, burun akıntısı ve hırıltılı solunum gibi belirtiler gösterebilirler.",
    "Parazitler veya bakteriyel enfeksiyonlar nedeniyle cilt rahatsızlıkları yaşayabilirler. Kaşıntı, kızarıklık veya kabuklanma gibi belirtiler görülebilir.",
    "Çin hamsterlarında böbreklerde sıvı dolu kistlerin oluştuğu bir durum olabilir. Bu, böbrek fonksiyonunu etkileyebilir.",
    "Dişlerin aşırı büyümesi, yeme güçlüğüne ve diş eti problemlerine yol açabilir.",
    "Bu durumda, kıkırdak ve kemik gelişiminde sorunlar yaşanarak eklem ağrısı ve hareket kısıtlılığı ortaya çıkabilir.",],
  imagePath:'asset/pictures-2/çinH.png',
  ),
  MyCard(
  titles:["Kişilik & Karakter Özellikleri","----------------------------","Sağlık Durumu",
    "Sindirim Problemleri",
    "Cilt Problemleri",
    "Diş Problemleri",
    "Stres ve Sosyal İzolasyon",],
  descriptions:["Avrupa Hamsterı, 30 cm.’lik boyuyla Hamster türlerinin en büyüğüdür."
  " Renk farklılığı ile de diğer türlerden ayrılır. Karın bölgesi siyah,"
  " sırtı kahverengi ve yan bölgeler beyazdır. Doğu Avrupa ve"
  " Batı Asya’da toprağın altında yaşar. Tarım alanlarına büyük zararlar vermesiyle bilinir.",

    "",
    "Avrupa hamsterı (Cricetus cricetus), genellikle sağlıklı ve dayanıklı kemirgenlerdir."
        " Ancak, evcil hayvan olarak beslenmeleri durumunda da bazı sağlık sorunları ortaya çıkabilir. ",
    "Yanlış beslenme, stres veya kirli içme suyu gibi faktörler sindirim sorunlarına yol açabilir.",
    "Parazitler veya bakteriyel enfeksiyonlar nedeniyle cilt rahatsızlıkları yaşanabilir.",
    "Aşırı diş büyümesi, yeme güçlüğüne ve diş eti problemlerine neden olabilir.",
    "Uygun yaşam alanı ve aktiviteler sunulmazsa stres yaşayabilirler.",],
  imagePath: 'asset/pictures-2/avrupaH.png',
  ),

  MyCard(
  titles:["Kişilik & Karakter Özellikleri","----------------------------","Sağlık Durumu",
    "Sindirim Problemleri",
    "Diş Problemleri",
    "Cilt Problemleri",
    "Stres ve Sosyal İzolasyon",],
  descriptions:["Gonzales hamster doğada yarı kurak bozkırları mesken edinir."
  " Burada kazdığı yaklaşık 1 metre uzunluğundaki yuvasında yaşar."
  " Yuvasının duvarlarına koyun yünü ve kuru otlarla kaplar. "
  "Bu sayede dışarıdaki hava -25 santigrat derece iken, içindeki sıcaklık "
  "15 santigrat derece civarında olur. Bu sıcaklık gonzales hamsterın yavrularını "
  "yetiştirmesi için ideal değerdir.",
    "",
    "Gonzales hamsterı, hamster türlerinden biri olan bir evcil hayvandır."
        " Sağlıklı bir Gonzales hamsterı, genellikle aktif, canlı ve iyi beslenmiş olacaktır."
        " Ancak, her türün olduğu gibi, bazı sağlık sorunları ortaya çıkabilir.",
    "Yanlış beslenme veya stres, kabızlık veya ishal gibi sindirim sorunlarına neden olabilir.",
    "Aşırı diş büyümesi, yeme güçlüğüne ve diş eti sorunlarına yol açabilir.",
    "Parazitler veya bakteriyel enfeksiyonlar, cilt rahatsızlıklarına neden olabilir.",
    "Gonzales hamsterları sosyal hayvanlar değildir, ancak uygun yaşam alanı ve aktiviteler sunulmazsa stres yaşayabilirler.",],
  imagePath:  'asset/pictures-2/gonzalesH.png',
  ),

  MyCard(
  titles:["Kişilik & Karakter Özellikleri","----------------------------","Sağlık Durumu",
    "Diş Problemleri",
    "Sindirim Sorunları",
    "Cilt Parazitleri",
    "Cilt Parazitleri",
    "Dış Parazitler",],
  descriptions:["Tür genel anlamda arkadaş canlısıdır ve evcil hayvan olarak beslenebilir. "
  "Sahiplenilen tavşanın sosyal bir canlı olması için yavruluğundan itibaren insanlarla"
  " etkileşim halinde olması gerekir. Günlük ihtiyaçlarının karşılanması için kafesinden"
  " çıkartılması iyi bir başlangıç olacaktır. Bu sayede insanlar tarafından tutulmaya alışır. "
  "Çocuklar tarafından beslenecekse, onlara tavşanı nasıl tutmaları gerektiği öğretilmelidir.",
    "",
    "Bu cins genellikle sağlıklı ve dayanıklı tavşanlar olarak bilinir.",
    "Sürekli büyüyen dişler nedeniyle diş sorunları yaşanabilir.",
    "Yanlış beslenme veya stres, kabızlık veya ishal gibi sindirim rahatsızlıklarına yol açabilir.",
    " Parazitler, tüy ve cilt sağlığını etkileyebilir.",
    "Soğuk ve nemli ortamlarda solunum yolu enfeksiyonları gelişebilir.",
  "Pire ve keneler gibi dış parazitlerin kontrol edilmesi önemlidir."],
  imagePath:  "asset/pictures-2/Hothot tavşanı (2).png",
  ),

  MyCard(
  titles:["Kişilik & Karakter Özellikleri","----------------------------","Sağlık Durumu",
    "Beslenme",
    "Diş Sağlığı",
    "Hareket ve Aktivite",
    "Cilt ve Tüy Sağlığı",
    "Sosyal İhtiyaçlar",],
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
  "hissi verecek, hem de komşu bahçelere kaçmasını önleyecektir.",
    "",
    "Hollanda Lop tavşanları, genellikle sağlıklı ve dayanıklı tavşanlardır."
        " Ancak, tüm tavşan cinslerinde olduğu gibi, bazı sağlık sorunlarına yatkınlıkları olabilir",
    "Hollanda Lop tavşanları için dengeli ve sağlıklı bir beslenme sağlamak önemlidir."
        " Kaliteli tavşan yemi, taze meyve, sebze ve saman vermek, sağlıklarını korumak için gereklidir.",
    "Tavşanlar sürekli büyüyen dişlere sahiptir, bu nedenle diş bakımı önemlidir."
        " Çiğneme materyalleri ve lifli yiyecekler vererek dişlerinin düzgün uzamasına yardımcı olunmalıdır.",
    " Hollanda Lop tavşanları aktif ve hareketli hayvanlardır. "
        "Uygun yaşam alanı ve düzenli egzersiz, fiziksel sağlıklarını destekler.",
    "Tavşanların tüyleri ve ciltleri düzenli olarak kontrol edilmeli, parazitlerden ve diğer cilt sorunlarından korunmalıdır.",
  "Tavşanlar sosyal hayvanlardır, bu nedenle sosyal etkileşim ve oyun zamanı sağlanmalıdır."],
  imagePath:  'asset/pictures-2/Hollanda Lop tavşanı (2).png',
  ),

  MyCard(
  titles:["Kişilik & Karakter Özellikleri","----------------------------","Sağlık Durumu",
    ],
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
  "evinizin diğer tarafına gitmesi gerekmiyor.",
    "",
    "Havana tavşanları, genellikle sağlıklı ve dayanıklı hayvanlar olarak bilinir."
        " Sağlıklı bir Havana tavşanı için dengeli bir beslenme, temiz bir yaşam ortamı ve düzenli veteriner kontrolleri önemlidir."
        " Egzersiz sağlanmalı, cilt ve tüy bakımına dikkat edilmelidir.",],
  imagePath: 'asset/pictures-2/Havana tavşanı (2).png',
  ),

  ];

  HomePage({super.key});


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
              _sizedBoxHeight10,
              Column(
                children: List.generate(
                  card.titles.length,
                      (index) => Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          card.titles[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        card.descriptions[index],
                        textAlign: TextAlign.start,
                      ),
                      _sizedBoxHeight10,
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Kapat'),
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
          preferredSize: const Size.fromHeight(20),
          child: Container(
           height: 75,
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _searchController,
                  decoration:const InputDecoration(
                    hintText: "Hayvan Ara",
                    hintStyle: TextStyle(fontSize: 17),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),

                suggestionsCallback: (pattern) {
                  return _getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  // Find the index of the suggestion in the names list
                  int index = names.indexOf(suggestion);

                  // Get the corresponding image path from the MyCard object
                  String imagePath = myCards[index].imagePath;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(imagePath),
                    ),
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  _searchController.clear();
                  int index = names.indexOf(suggestion);
                  MyCard card = myCards[index];
                  _showCard(context, card);
                },
              ),
            ),
          ),
        ),
      ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width,
              height: 28,
              child: const Stack(
                children: [
                  Text(
                    'Köpekler', style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            _sizedBoxHeight10,

      Flex(
        direction: Axis.horizontal,
        children: [
        Expanded(
        flex: 1,
        child:SizedBox(
              width: MediaQuery.of(context).size.width -0,
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
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
                ],
              ),),),],),

                     SizedBox(width: MediaQuery.of(context).size.width,
                            height: 24,
                            child: const Stack(
                              children: [
                                Text(
                                  'Kediler', style: TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                            _sizedBoxHeight10,

      Flex(
        direction: Axis.horizontal,
        children: [
        Expanded(
        flex: 1,
        child:SizedBox(
                            width: MediaQuery.of(context).size.width -0,
                            height: 160,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Column(
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
                              ],
                            ),),
    ),],),






                            SizedBox(width: MediaQuery.of(context).size.width,
                            height: 24,
                            child: const Stack(
                              children: [
                                Text(
                                  'Hamstırlar', style: TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          _sizedBoxHeight10,

    Flex(
    direction: Axis.horizontal,
    children: [
    Expanded(
    flex: 1,
    child: SizedBox(
                            width: MediaQuery.of(context).size.width -0,
                            height: 160,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Column(
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
    ],
    ),),),],),



             SizedBox(width: MediaQuery.of(context).size.width,
              height: 24,
              child:const Stack(
                children: [
                  Text(
                    'Tavşanlar', style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            _sizedBoxHeight10,

      Flex(
        direction: Axis.horizontal,
        children: [
        Expanded(
        flex: 1,
        child:SizedBox(
              width: MediaQuery.of(context).size.width -0,
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                   Column(
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
                ],
              ),),),],),




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

