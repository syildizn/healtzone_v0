import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/profilPage/profilPageViewModel.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  static String routeName = "ProfilPage";
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String? isimSoyisim;
  int? yas;
  String? telefon;
  String? adres;
  String? sehir;
  String? email;
  String? cinsiyet;

  @override
  void initState() {
    super.initState();
    //getUserData();
    Provider.of<ProfilPageViewModel>(context, listen: false).getUserData();

  }

  // getUserData() async {
  //   DocumentSnapshot? documentSnapshot =
  //       await Provider.of<ProfilPageViewModel>(context, listen: false)
  //           .getUser();
  //
  //   if (documentSnapshot != null) {
  //     setState(() {
  //       isimSoyisim = documentSnapshot['name'];
  //       yas = documentSnapshot['age'];
  //       telefon = documentSnapshot['phone'];
  //       adres = documentSnapshot['address'];
  //       sehir = documentSnapshot['city'];
  //       email = documentSnapshot['email'];
  //       cinsiyet = documentSnapshot['sex'];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ProfilPageViewModel viewModel = Provider.of<ProfilPageViewModel>(context);
    print("aha aradığım mail: ${viewModel.email}");
    return ChangeNotifierProvider<ProfilPageViewModel>(
      create: (_) => ProfilPageViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue.shade400,
          title: Text("Profil Sayfası"),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade200, Colors.white],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/anonym.png'), // Kullanıcı avatarı için buraya resim yolu ekleyin.
              ),
              SizedBox(height: 20),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profilBilgisi("İsim Soyisim:", viewModel.isimSoyisim),
                      Divider(),
                      profilBilgisi("Yaş:", viewModel.yas.toString()),
                      Divider(),
                      profilBilgisi("Telefon:", viewModel.telefon),
                      Divider(),
                      profilBilgisi("Adres:", viewModel.adres),
                      Divider(),
                      profilBilgisi("Şehir:", viewModel.sehir),
                      Divider(),
                      profilBilgisi("Email:", viewModel.email),
                      Divider(),
                      profilBilgisi("Cinsiyet:", viewModel.cinsiyet),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profilBilgisi(String? baslik, String? bilgi) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            baslik == null ? "Girilmedi" : baslik,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            bilgi == null ? "Girilmedi" : bilgi,
            style: TextStyle(fontSize: 16, color: Colors.teal.shade900),
          ),
        ],
      ),
    );
  }
}
