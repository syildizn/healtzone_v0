import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healtzone_v0/screens/doctor.dart';
import 'package:healtzone_v0/screens/offers.dart';
import 'package:intl/intl.dart';

import 'models/homePageCategoriesModel.dart';

//ilan sayfası-ana sayfa
class PublicationsScreen extends StatefulWidget {
  static String routeName = "PublicationsPage";
  const PublicationsScreen({Key? key}) : super(key: key);

  @override
  State<PublicationsScreen> createState() => _PublicationsScreenState();
}

class _PublicationsScreenState extends State<PublicationsScreen> {
  int currentPage = 1; //  1: İlanlarım, 2: Doktor Bul, 3: Teklifler

  TextEditingController searchController = TextEditingController();

  List<CategoryModel> categories = [
    CategoryModel(
      name: 'Kadın Doğum',
      svgPath: 'assets/icons/obstetrics.svg', // SVG dosyasının yolu
      onTap: () {
        print("tıklandı 1 ");
      },
    ),
    CategoryModel(
      name: 'Diş Doktoru',
      svgPath: 'assets/icons/dentist.svg', // SVG dosyasının yolu
      onTap: () {
        print("tıklandı 2 ");
      },
    ),
    // Diğer kategorileri burada ekleyebilirsiniz
  ];

  List<CategoryModel> filteredCategories = [];


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    filteredCategories = categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İlanlarım")),
      body: Column(
        children: <Widget>[
          Padding(//üstteki üç tuş
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: currentPage == 1 ? Colors.blue : Colors.white,
                        onPrimary:
                            currentPage == 1 ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        // 360 view butonuna tıklandığında yapılacak işlemler
                        setState(() {
                          currentPage = 1;
                        });
                        Navigator.pushNamed(
                            context, PublicationsScreen.routeName);
                      },
                      child: Text('İlanlarım'),
                    ),
                  ),
                  Container(width: 2, color: Colors.black),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: currentPage == 2 ? Colors.blue : Colors.white,
                        onPrimary:
                            currentPage == 2 ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        // Text butonuna tıklandığında yapılacak işlemler
                        setState(() {
                          currentPage = 2;
                        });
                        Navigator.pushNamed(context, Doctor.routeName);
                      },
                      child: Text('Doktor Bul'),
                    ),
                  ),
                  Container(width: 2, color: Colors.black),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: currentPage == 3 ? Colors.blue : Colors.white,
                        onPrimary:
                            currentPage == 3 ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        // Smart Screen butonuna tıklandığında yapılacak işlemler
                        setState(() {
                          currentPage = 3;
                        });
                        Navigator.pushNamed(context, OffersPage.routeName);
                      },
                      child: Text('Teklifler'),
                    ),
                  ),
                ],
              )),
          // aşağısı kategori arama işlemini yapıyor
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZğüışöçİĞÜŞÖÇ]')),
                ],
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Kategori ara...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
                onChanged: (value) {
                  setState(() {
                    filteredCategories = categories
                        .where((category) =>
                        category.name.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
          ),


                // aşağısı kategorileri oluşturan kısım
          Expanded(flex: 5,
            child: ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: filteredCategories[index].onTap,
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          filteredCategories[index].svgPath,
                          width: 55,
                          height: 55,
                        ),
                        Text(filteredCategories[index].name,style: TextStyle(fontSize: 22)),
                      ],
                    ),
                  ),
                );
              },
            ),

          ),
          // sağ alt köşedeki tuş
          Expanded(flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 400,
                height: 300,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 50,
                      right: 90,
                      child: Text('İlan Ver',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 25,
                      child: FloatingActionButton(
                        onPressed: () {
                          // İlan Ver butonuna tıklandığında yapılacak işlemler
                          ilanver();
                        },
                        child: Icon(Icons.add),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
  
          // Diğer widget'lar buraya eklenebilir
        ],
      ),
    );
  }

  void ilanver() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference doctorsRef = FirebaseFirestore.instance.collection('doctors');

    doctorsRef.add({
      'department': "Deli Doktoru", // John Doe
      'name': "Mahmut", // Stokes and Sons
      'no': "10" // 42
    }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

  }
}
