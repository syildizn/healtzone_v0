import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/detailedUltrasound/detailedUltrasoundViewModel.dart';
import 'package:provider/provider.dart';

import '../../../homePage/publications.dart';
import '../../../profilPage/profilPage.dart';
import '../../../profilPage/profilPageViewModel.dart';

class DetailedUltrasound extends StatefulWidget {
  static String routeName = "DetailedUltrasoundPage";
  const DetailedUltrasound({Key? key}) : super(key: key);

  @override
  State<DetailedUltrasound> createState() => _DetailedUltrasoundState();
}

class _DetailedUltrasoundState extends State<DetailedUltrasound> {
  String _pregnancyWeek = '';
  bool? _hadPreviousIssues;
  String _previousIssuesText = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailedUltraViewModel>(
      create: (_) => DetailedUltraViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Ayrıntılı Ultrasonografi ',
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade200, Colors.white],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              _buildCard(
                title: 'Bilgilendirme',
                child: Text(
                  'Ayrıntılı Ultrasonografi (Fetal Anomali Taraması) gebeliğin 18-23. haftaları arasında yapılmaktadır ',
                  style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),
                ),
              ),
              _buildCard(
                title: 'Kaçıncı gebelik haftasındasınız? (Örneğin: 21. hafta)',
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Gebelik Haftası',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _pregnancyWeek = value;
                  },
                ),
              ),
              _buildCard(
                title:
                    'Şimdiki yada daha önceki gebeliğinizde herhangi bir sorun yaşadınızmı?',
                child: Row(
                  children: [
                    Text('Hayır'),
                    Radio(
                      value: false,
                      groupValue: _hadPreviousIssues,
                      onChanged: (bool? value) {
                        setState(() {
                          _hadPreviousIssues = value;
                        });
                      },
                    ),
                    Text('Evet'),
                    Radio(
                      value: true,
                      groupValue: _hadPreviousIssues,
                      onChanged: (bool? value) {
                        setState(() {
                          _hadPreviousIssues = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_hadPreviousIssues == true)
                _buildCard(
                  title: 'Lütfen sorunları belirtin',
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Sorunlar',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _previousIssuesText = value;
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    // Handle submission or navigate to the next page
                    try{
                      await Provider.of<DetailedUltraViewModel>(context,
                          listen: false)
                          .getUserData();
                      await Provider.of<DetailedUltraViewModel>(context,
                          listen: false)
                          .detailedUltrasound(
                          _hadPreviousIssues,
                          _pregnancyWeek,
                          _previousIssuesText);
                      print("detailedUltra tuşuna basıldı");


                      // İşlemler tamamlandıktan sonra showDialog fonksiyonu çağırılır
                      showDialog(
                        context: context,
                        barrierDismissible: false,  // Dialog dışına tıklanamaz
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),  // Yuvarlak köşeler
                            ),
                            elevation: 16,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,  // İçeriği saran boyut
                                children: <Widget>[
                                  Text(
                                    'İşlem Başarılı',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20),  // Boşluk
                                  Text(
                                    'İşlem başarılı, ilanınız başarıyla yayınlandı, ilanlarım sayfasından takip edebilirsiniz.',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 20),  // Boşluk
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();  // Dialog'u kapat
                                      Navigator.pushNamed(context, PublicationsScreen.routeName);  // Yeni sayfaya yönlendir
                                    },
                                    child: Text('Tamam'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }catch(e){
                      print(e.toString());
                    }
                  },
                  child: Text('Gönder'),
                ),
              ),
            ],
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
                    Navigator.pushNamed(context, PublicationsScreen.routeName);
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
              SizedBox(), // Orta boşluk
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
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
