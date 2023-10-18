import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/homePage/publications.dart';
import 'package:healtzone_v0/screens/profilPage/profilPage.dart';
import 'package:healtzone_v0/screens/profilPage/profilPageViewModel.dart';
import 'package:provider/provider.dart';

import 'doctorPage/doctor.dart';

class OffersPage extends StatefulWidget {
  static String routeName = "OffersPage";
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  int currentPage = 3; // 1: İlanlarım, 2: Doktor Bul, 3: Teklifler
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teklifler")),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: currentPage == 1 ? Colors.blue : Colors.white,
                        onPrimary: currentPage == 1 ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        // 360 view butonuna tıklandığında yapılacak işlemler
                        setState(() {
                          currentPage = 1;
                        });
                        Navigator.pushNamed(context,
                            PublicationsScreen.routeName);
                      },
                      child: Text('İlanlarım'),
                    ),
                  ),
                  Container(width: 2, color: Colors.black),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: currentPage == 2 ? Colors.blue : Colors.white,
                        onPrimary: currentPage == 2 ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        // Text butonuna tıklandığında yapılacak işlemler
                        setState(() {
                          currentPage = 2;
                        });
                        Navigator.pushNamed(context,
                            Doctor.routeName);
                      },
                      child: Text('Doktor Bul'),
                    ),
                  ),
                  Container(width: 2, color: Colors.black),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: currentPage == 3 ? Colors.blue : Colors.white,
                        onPrimary: currentPage == 3 ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        // Smart Screen butonuna tıklandığında yapılacak işlemler
                        setState(() {
                          currentPage = 3;
                        });
                        Navigator.pushNamed(context,
                            OffersPage.routeName);

                      },
                      child: Text('Teklifler'),
                    ),
                  ),
                ],
              )

          ),



          // Diğer widget'lar buraya eklenebilir
        ],
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
}
