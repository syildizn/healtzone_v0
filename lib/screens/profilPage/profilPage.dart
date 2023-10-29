import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/editProfile/editPatProfileViewModel.dart';
import 'package:healtzone_v0/screens/editProfile/editPatientsProfile.dart';
import 'package:healtzone_v0/screens/profilPage/profilPageViewModel.dart';
import 'package:healtzone_v0/screens/widgets/myCustomButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../homePage/publications.dart';

class ProfilPage extends StatefulWidget {
  static String routeName = "ProfilPage";
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String? photUrl ;
  File? imageFile;
  final picker = ImagePicker();

  @override
  // void initState() {
  //   super.initState();
  //   //getUserData();
  //   Provider.of<ProfilPageViewModel>(context, listen: false).listenUserData();
  // }
  //var document;
  @override
  Widget build(BuildContext context) {
    ProfilPageViewModel viewModel =
        Provider.of<ProfilPageViewModel>(context, listen: false);
    print("aha aradığım mail: ${viewModel.email}");

    return ChangeNotifierProvider<ProfilPageViewModel>(
      create: (_) => ProfilPageViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue.shade400,
          title: Text("Profil Sayfası"),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: viewModel.listenUserData(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('Bilgi bulunamadı'));
              }

             // var document = snapshot!.data;
              DocumentSnapshot<Object?>? document = snapshot.data;
              // if (snapshot.data != null && snapshot.data!.exists) {
              //    document = snapshot.data!;
              //   if (document.contains('completedProfile')) {
              //     //completedProfileLocal = document['completedProfile'];  // Burada değişkeni ayarlayın
              //   } else {
              //     print('completedProfile alanı belgede bulunamadı');
              //     return Center(child: Text('completedProfile alanı belgede bulunamadı'));
              //   }
              // }

              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade200, Colors.white],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      FutureBuilder<ImageProvider<Object>>(
                        future: Provider.of<ProfilPageViewModel>(context,listen: false).image(document?['photoUrl']),
                        builder: (BuildContext context, AsyncSnapshot<ImageProvider<Object>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            print("ProfilPage avatar if");
                            // Yükleniyor iken gösterilecek widget
                            return CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/images/anonym.png'),
                            );
                          } else if (snapshot.hasError) {
                            // Hata olduğunda gösterilecek widget
                            print("ProfilPage avatar else if");
                            return Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage('assets/images/anonym.png'),
                                ),
                                IconButton(onPressed: getImagePicker,  icon: Icon(Icons.edit,color:Colors.grey[600] ,),)
                              ],
                            );
                          } else {
                            // Veri geldiğinde gösterilecek widget
                            print("ProfilPage avatar else");
                            return Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: snapshot.data, //FileImage(imageFile!),
                                ),
                                IconButton(onPressed: getImagePicker, icon: Icon(Icons.edit,color: Colors.grey[600]),)
                              ],
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              profilBilgisi("İsim Soyisim:", document?['name']),
                              Divider(),
                              profilBilgisi("Doğum tarihi:", document?['birthDay'].toString()),
                              Divider(),
                              profilBilgisi("Telefon:", document?['phone']),
                              Divider(),
                              profilBilgisi("Adres:", document?['address']),
                              Divider(),
                              profilBilgisi("Şehir:", document?['city']),
                              Divider(),
                              profilBilgisi("Email:", document?['email']),
                              Divider(),
                              profilBilgisi("Cinsiyet:", document?['sex']),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyCustomButton(
                            text: "Profili Düzenle",
                            backgroundColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (context) =>
                                        EditPatientsProfilViewModel(),
                                    child: EditPatientsProfile(),
                                  ),
                                ),
                              );
                            },
                            svgPath: 'assets/icons/edittwo.svg',
                            textColor: Colors.black,
                            SizedBoxRange: 25),
                      )
                    ],
                  ),
                ),
              );
            }),
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

  Future getImagePicker() async  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,maxHeight: 200);

    setState(() {
      if(pickedFile != null){
        imageFile = File(pickedFile.path);
        print("imagerPicker FilePath: $imageFile");
      }else{
        print("No Image Selected");
      }
    });

    if(imageFile != null){
      await Provider.of<ProfilPageViewModel>(context, listen: false).uploadImage(imageFile!);
    }
  }
}
