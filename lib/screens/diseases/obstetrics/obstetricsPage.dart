import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/detailedUltrasound/detailedUltrasoundPage.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/genitalAesthetics/genitalAestheticsPage.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/inVitroFertilization/inVitroFertilizationPage.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/pregnancyAndBirth/pregnancyAndBirthPage.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/surgeries/surgeriesPage.dart';
import 'package:provider/provider.dart';

import '../../homePage/publications.dart';
import '../../profilPage/profilPage.dart';
import '../../profilPage/profilPageViewModel.dart';

class Obstetrics extends StatefulWidget {
  static String routeName = "ObstetricsPage";
  const Obstetrics({Key? key}) : super(key: key);

  @override
  _ObstetricsState createState() => _ObstetricsState();
}

class _ObstetricsState extends State<Obstetrics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tedavi Seçimi'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'Lütfen tedavi almak istediğiniz Kadın Hastalıkları ve Doğum alanını seçiniz',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildOption(
                      context,
                      title: '1-GEBELİK TAKİBİ VE DOĞUM',
                      icon: Icons.family_restroom,
                      onTap: () => Navigator.pushNamed(context, PregnancyAndBirth.routeName),
                    ),
                    _buildOption(
                      context,
                      title: '2-TÜP BEBEK TEDAVİSİ',
                      icon: Icons.child_care,
                      onTap: () => Navigator.pushNamed(context, InVitroFertilization.routeName),
                    ),
                    _buildOption(
                      context,
                      title: '3-GENİTAL ESTETİK',
                      icon: Icons.spa,
                      onTap: () => Navigator.pushNamed(context, GenitalAesthetics.routeName),
                    ),
                    _buildOption(
                      context,
                      title: '4-AYRINTILI ULTRASONOGRAFİ (FETAL ANOMALİ TARAMASI)',
                      icon: Icons.medical_services,
                      onTap: () => Navigator.pushNamed(context, DetailedUltrasound.routeName),
                    ),
                    _buildOption(
                      context,
                      title: '5-AMELİYATLAR',
                      icon: Icons.healing,
                      onTap: () => Navigator.pushNamed(context, Surgeries.routeName),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  Widget _buildOption(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade700),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
