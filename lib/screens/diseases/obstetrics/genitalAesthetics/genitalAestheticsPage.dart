import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/genitalAesthetics/genitalAestheticsViewModel.dart';
import 'package:provider/provider.dart';

import '../../../homePage/publications.dart';
import '../../../profilPage/profilPage.dart';
import '../../../profilPage/profilPageViewModel.dart';

class GenitalAesthetics extends StatefulWidget {
  static String routeName = "GenitalAestheticsPage";
  const GenitalAesthetics({Key? key}) : super(key: key);

  @override
  State<GenitalAesthetics> createState() => _GenitalAestheticsState();
}

class _GenitalAestheticsState extends State<GenitalAesthetics> {
  bool? _hadPreviousSurgery;
  bool? _hadProfessionalExamination;
  String? _recommendedProcedure;
  String? _desiredProcedure;
  String? _otherProcedure;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GenitalAestheticsViewModel>(
      create: (_) => GenitalAestheticsViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text('Genital Estetik'),
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
                title: 'Daha önce genital estetik ameliyatı oldunuz mu?',
                child: Row(
                  children: [
                    Text('Hayır'),
                    Radio(
                      value: false,
                      groupValue: _hadPreviousSurgery,
                      onChanged: (bool? value) {
                        setState(() {
                          _hadPreviousSurgery = value;
                        });
                      },
                    ),
                    Text('Evet'),
                    Radio(
                      value: true,
                      groupValue: _hadPreviousSurgery,
                      onChanged: (bool? value) {
                        setState(() {
                          _hadPreviousSurgery = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_hadPreviousSurgery == true)
                _buildCard(
                  title: 'Lütfen detayları belirtin',
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Detaylar',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // ...
                      _otherProcedure = value;
                    },
                  ),
                ),
              _buildCard(
                title:
                    'Daha önce uzman tarafından muayene olduysanız önerilen genital estetik işlemi var mı?',
                child: Row(
                  children: [
                    Text('Hayır'),
                    Radio(
                      value: false,
                      groupValue: _hadProfessionalExamination,
                      onChanged: (bool? value) {
                        setState(() {
                          _hadProfessionalExamination = value;
                        });
                      },
                    ),
                    Text('Evet'),
                    Radio(
                      value: true,
                      groupValue: _hadProfessionalExamination,
                      onChanged: (bool? value) {
                        setState(() {
                          _hadProfessionalExamination = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_hadProfessionalExamination == true)
                _buildCard(
                  title: 'Önerilen işlemi belirtin',
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Önerilen İşlem',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _recommendedProcedure = value;
                    },
                  ),
                ),
              _buildCard(
                title: 'İstediğiniz genital estetik işlemi hangisidir?',
                child: DropdownButton<String>(
                  value: _desiredProcedure,
                  items: [
                    DropdownMenuItem(
                      value: 'Labioplasti',
                      child: Text('Labioplasti'),
                    ),
                    DropdownMenuItem(
                      value: 'Klitoris Estetiği',
                      child: Text('Klitoris Estetiği'),
                    ),
                    DropdownMenuItem(
                      value: 'Vajen daraltma',
                      child: Text('Vajen daraltma'),
                    ),
                    DropdownMenuItem(
                      value: 'Vulva Beyazlatma',
                      child: Text('Vulva Beyazlatma'),
                    ),
                    DropdownMenuItem(
                      value: 'Hymenoplasti (Kızlık zarı dikimi)',
                      child: Text('Hymenoplasti (Kızlık zarı dikimi)'),
                    ),
                    DropdownMenuItem(
                      value: 'Doğum izi düzeltilmesi',
                      child: Text('Doğum izi düzeltilmesi'),
                    ),
                    DropdownMenuItem(
                      value: 'Diğer',
                      child: Text('Diğer'),
                    ),
                  ],
                  hint: Text('Seçiniz'),
                  onChanged: (String? value) {
                    setState(() {
                      _desiredProcedure = value;
                      if (value == 'Diğer') {
                        _otherProcedure =
                            ''; // Reset the otherProcedure field for user input
                      }
                    });
                  },
                ),
              ),
              if (_desiredProcedure == 'Diğer')
                _buildCard(
                  title: 'Lütfen diğer işlemi belirtin',
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Diğer İşlem',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _otherProcedure = value;
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
                    await Provider.of<GenitalAestheticsViewModel>(context,
                            listen: false)
                        .getUserData();
                    await Provider.of<GenitalAestheticsViewModel>(context,
                            listen: false)
                        .genitalAest(
                            _hadPreviousSurgery,
                            _desiredProcedure,
                            _otherProcedure,
                            _hadProfessionalExamination,
                            _recommendedProcedure);
                    print("genital tuşuna basıldı");
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
