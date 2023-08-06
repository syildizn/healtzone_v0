import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/doctor.dart';
import 'package:healtzone_v0/screens/offers.dart';

class PublicationsScreen extends StatefulWidget {
  static String routeName = "PublicationsPage";
  const PublicationsScreen({Key? key}) : super(key: key);

  @override
  State<PublicationsScreen> createState() => _PublicationsScreenState();
}

class _PublicationsScreenState extends State<PublicationsScreen> {

  int currentPage = 1; //  1: İlanlarım, 2: Doktor Bul, 3: Teklifler


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İlanlarım")),
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
          Expanded(
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
                      child: Text('İlan Ver',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 25,
                      child: FloatingActionButton(
                        onPressed: () {
                          // İlan Ver butonuna tıklandığında yapılacak işlemler
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
}
