import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/publications.dart';

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

    );
  }
}
