import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petcare/tasarim_UI/tema.dart';
import 'main.dart';

class VetPage extends StatefulWidget {
  const VetPage({Key? key});

  @override
  State<VetPage> createState() => _VetPageState();
}

class _VetPageState extends State<VetPage> {
  var collection = FirebaseFirestore.instance.collection("Veterinarians");
  late List<Map<String, dynamic>> items = [];
  late List<Map<String, dynamic>> filteredItems = [];
  bool isLoaded = false;
  TextEditingController _searchController = TextEditingController();

  void _incrementCounter() async {
    List<Map<String, dynamic>> tempList = [];
    var data = await collection.get();
    data.docs.forEach((element) {
      tempList.add(element.data() as Map<String, dynamic>);
    });

    setState(() {
      items = tempList;
      filteredItems = tempList;
      isLoaded = true;
    });
  }

  void _filterList(String keyword) {
    setState(() {
      filteredItems = items
          .where((item) =>
              item["name"].toString().toLowerCase().contains(keyword.toLowerCase()) ||
              item["İŞ"].toString().toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyApp();
              }));
            },
          ),
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Aramak İstediğiniz Kelimeyi Girin!",
              suffixIcon: const Icon(Icons.search, color: Colors.blueGrey,),
              border: OutlineInputBorder(
                borderSide: const BorderSide(),
              )
            ),
            onChanged: (value) {
              _filterList(value);
            },
          ),
          // Diğer AppBar özellikleri
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 45,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.indigo,
                        ),
                        title: Column(
                          children: [
                            Text(filteredItems[index]["name"] ?? "Veri Yok"),
                            SizedBox(
                              width: 10,
                            ),
                            Text(filteredItems[index]["Bio"] ?? "Veri Yok"),
                          ],
                        ),
                      );
                  },
                ),
              ),
            ],
          ),
        ),
        // Diğer Scaffold içeriği
      ),
    );
  }
}
