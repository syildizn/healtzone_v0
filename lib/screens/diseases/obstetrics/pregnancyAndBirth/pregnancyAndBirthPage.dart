import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/pregnancyAndBirth/preAndBirthViewModel.dart';
import 'package:provider/provider.dart';

import '../../../homePage/publications.dart';
import '../../../profilPage/profilPage.dart';
import '../../../profilPage/profilPageViewModel.dart';

class PregnancyAndBirth extends StatefulWidget {
  static String routeName = "PregnancyAndBirthPage";
  const PregnancyAndBirth({Key? key}) : super(key: key);

  @override
  State<PregnancyAndBirth> createState() => _PregnancyAndBirthState();
}

class _PregnancyAndBirthState extends State<PregnancyAndBirth> {
  bool? _hadPreviousDelivery;
  String? _deliveryMethod;
  String _pregnancyWeek = '';
  bool? _anyConcerns;
  String _concernsText = '';
  String? _serviceRequired;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PreAndBirthViewModel>(
      create: (_) => PreAndBirthViewModel() ,
      builder: (context, _) =>  Scaffold(
        appBar: AppBar(
          title: Text('Gebelik Takibi Ve Doğum'),
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
                title: 'Daha önce doğum yaptınız mı?',
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Evet'),
                        Radio(
                          value: true,
                          groupValue: _hadPreviousDelivery,
                          onChanged: (bool? value) {
                            setState(() {
                              _hadPreviousDelivery = value;
                            });
                          },
                        ),
                        Text('Hayır'),
                        Radio(
                          value: false,
                          groupValue: _hadPreviousDelivery,
                          onChanged: (bool? value) {
                            setState(() {
                              _hadPreviousDelivery = value;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_hadPreviousDelivery == true)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Normal Doğum mu Sezeryan mı?'),
                          Row(
                            children: [
                              Text('Normal Doğum'),
                              Radio(
                                value: 'Normal Doğum',
                                groupValue: _deliveryMethod,
                                onChanged: (String? value) {
                                  setState(() {
                                    _deliveryMethod = value;
                                  });
                                },
                              ),
                              Text('Sezeryan'),
                              Radio(
                                value: 'Sezeryan',
                                groupValue: _deliveryMethod,
                                onChanged: (String? value) {
                                  setState(() {
                                    _deliveryMethod = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              _buildCard(
                title: 'Gebeliğinizin kaçıncı haftasındasınız?',
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Örneğin: 23. hafta',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _pregnancyWeek = value;
                  },
                ),
              ),
              _buildCard(
                title:
                    'Gebeliğiniz ile ilgili belirtmek istediğiniz bir durum var mı?',
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Hayır'),
                        Radio(
                          value: false,
                          groupValue: _anyConcerns,
                          onChanged: (bool? value) {
                            setState(() {
                              _anyConcerns = value;
                            });
                          },
                        ),
                        Text('Evet'),
                        Radio(
                          value: true,
                          groupValue: _anyConcerns,
                          onChanged: (bool? value) {
                            setState(() {
                              _anyConcerns = value;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_anyConcerns == true)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Lütfen durumunuzu belirtiniz',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _concernsText = value;
                        },
                      ),
                  ],
                ),
              ),
              _buildCard(
                title: 'İhtiyacınız olan hizmet hangisidir?',
                child: DropdownButton<String>(
                  value: _serviceRequired,
                  items: [
                    DropdownMenuItem(
                      value: 'Gebelik Takibi',
                      child: Text('Gebelik Takibi'),
                    ),
                    DropdownMenuItem(
                      value: 'Doğum',
                      child: Text('Doğum'),
                    ),
                  ],
                  hint: Text('Seçiniz'),
                  onChanged: (String? value) {
                    setState(() {
                      _serviceRequired = value;
                    });
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
                  onPressed: () async{
                    // Handle submission or navigate to the next page
                    try{
                      await Provider.of<PreAndBirthViewModel>(context, listen: false).getUserData();
                      await Provider.of<PreAndBirthViewModel>(context,listen: false).preAndBirth(
                          _hadPreviousDelivery,
                          _deliveryMethod ,
                          _pregnancyWeek,
                          _anyConcerns,
                          _concernsText,
                          _serviceRequired);
                      print("birth tuşuna basıldı");
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
