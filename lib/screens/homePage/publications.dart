import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/obstetricsPage.dart';
import 'package:healtzone_v0/screens/doctorPage/doctor.dart';
import 'package:healtzone_v0/screens/homePage/publicationsVievModel.dart';
import 'package:healtzone_v0/screens/offers.dart';
import 'package:healtzone_v0/screens/profilPage/profilPage.dart';
import 'package:healtzone_v0/screens/profilPage/profilPageViewModel.dart';
import 'package:healtzone_v0/services/authentication.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/homePageCategoriesModel.dart';

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
  PublicationsViewModel viewModel = PublicationsViewModel();
  bool? completedProfileLocal;
  List<CategoryModel> categories = [];
  var document;

  // @override
  // void initState() {
  //   super.initState();
  //   filteredCategories = categories;
  //   getCompleted();
  //   initializeCategories();
  // }

  @override
  void initState() {
    super.initState();
    getCompleted().then((_) {
      initializeCategories();
      setState(() {
        filteredCategories = categories;
      });
    });
  }


  Future<void> getCompleted() async {
    //completedProfileLocal  = await viewModel.getUserData();
    //completedProfileLocal  = document['completedProfile'];
    print("aha bu benim completed: $completedProfileLocal");
  }

  void handleTap(BuildContext context, String routeName) {
    if (completedProfileLocal == true) {
      Navigator.pushNamed(context, routeName);
      print("tıklandı: $routeName");
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Profil Bilgileri Eksik'),
          content: Text(
              'Lütfen profil düzenleme kısmından tüm bilgilerinizi tamamlayınız. Aksi halde ilan veremezsiniz.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  void initializeCategories() {
    categories = [
      CategoryModel(
        name: 'Kadın Doğum',
        svgPath: 'assets/icons/obstetrics.svg',
        onTap: (BuildContext context) {
          handleTap(context, Obstetrics.routeName);
        },
      ),
      CategoryModel(
        name: 'Diş Doktoru',
        svgPath: 'assets/icons/dentist.svg',
        onTap: (BuildContext context) {
         // handleTap(context, Dentist.routeName);  // varsayımsal bir routeName
        },
      ),
      // ... diğer CategoryModel öğeleri ...
    ];
  }

  // List<CategoryModel> categories = [
  //   CategoryModel(
  //     name: 'Kadın Doğum',
  //     svgPath: 'assets/icons/obstetrics.svg', // SVG dosyasının yolu
  //     // onTap: (BuildContext context) {
  //     //   Navigator.pushNamed(
  //     //       context, Obstetrics.routeName);
  //     //   print("tıklandı 1 ");
  //     // },
  //     onTap: (BuildContext context) {
  //       handleTap(context, Obstetrics.routeName);
  //     },
  //
  //   ),
  //   CategoryModel(
  //     name: 'Diş Doktoru',
  //     svgPath: 'assets/icons/dentist.svg', // SVG dosyasının yolu
  //     onTap: (BuildContext context) {
  //       print("tıklandı 2 ");
  //     },
  //   ),
  //   // Diğer kategorileri burada ekleyebilirsiniz
  // ];

  List<CategoryModel> filteredCategories = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İlanlarım"), elevation: 0.0,
          backgroundColor: Colors.blue.shade400,actions: [
        IconButton(onPressed: () async {
          await Provider.of<Authentication>(context,listen: false).signOut();
        }, icon: Icon(Icons.exit_to_app))
      ]),
      body: StreamBuilder<DocumentSnapshot>(
        stream: viewModel.listenUserData(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Bilgi bulunamadı'));
          }

          document = snapshot.data!;
          completedProfileLocal = document['completedProfile'];  // Burada değişkeni ayarlayın
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade200, Colors.white],
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                    //üstteki üç tuş
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: currentPage == 1 ? Colors.blue.shade400 : Colors.white,
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
                              primary: currentPage == 2 ? Colors.blue.shade400 : Colors.white,
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
                              primary: currentPage == 3 ? Colors.blue.shade400 : Colors.white,
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
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-ZğüışöçİĞÜŞÖÇ]')),
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
                              .where((category) => category.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                ),

                // aşağısı kategorileri oluşturan kısım
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          filteredCategories[index].onTap(context);
                        },
                        child: Container(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                              Text(filteredCategories[index].name,
                                  style: TextStyle(fontSize: 22)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Diğer widget'lar buraya eklenebilir
              ],
            ),
          );
        }
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  // TODO: İlanlarım ikonuna tıklandığında yapılacak işlemler
                  Navigator.pushNamed(
                      context, PublicationsScreen.routeName);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // TODO: Doktor Bul ikonuna tıklandığında yapılacak işlemler
                },
              ),
            ),
            SizedBox(),  // Orta boşluk
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // TODO: Bildirimler ikonuna tıklandığında yapılacak işlemler
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // TODO: Profilim ikonuna tıklandığında yapılacak işlemler
                  // Navigator.pushNamed(
                  //     context, "ProfilPage");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => ProfilPageViewModel(),
                        child: ProfilPage(),
                      ),
                    ),
                  );


                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // TODO: İlan Ver butonuna tıklandığında yapılacak işlemler
          //ilanver();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }

  void ilanver() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference doctorsRef =
        FirebaseFirestore.instance.collection('doctors');

    doctorsRef
        .add({
          'department': "Deli Doktoru", // John Doe
          'name': "Mahmut", // Stokes and Sons
          'no': "10" // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
