import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/publications.dart';
import 'package:provider/provider.dart';

import '../models/doctorModel.dart';
import 'doctorViewModel.dart';
import '../offers.dart';

class Doctor extends StatefulWidget {
  static String routeName = "DoctorPage";
  const Doctor({Key? key}) : super(key: key);

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  //final FirebaseFirestore database = FirebaseFirestore.instance;
  // Map<String, dynamic> doctortoAdd = {
  //   "department": "çıkrıkçı",
  //   "name": "trabzonlu deli hüseyin",
  //   "no": "46"
  // };

  int currentPage = 2; //  1: İlanlarım, 2: Doktor Bul, 3: Teklifler
  @override
  Widget build(BuildContext context) {
    //final CollectionReference doctorRef = database.collection("doctors");
    // final DocumentReference firstDoctorRef =
    //     doctorRef.doc("A3B9N0uzRlHZFgIHUkfH");

    return ChangeNotifierProvider<DoctorViewModel>(
      create: (BuildContext context) { return DoctorViewModel();  },
      builder:(context, child) =>  Scaffold(
        appBar: AppBar(title: Text("Doktor Bul")),
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
                          primary: currentPage == 2 ? Colors.blue : Colors.white,
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
                          primary: currentPage == 3 ? Colors.blue : Colors.white,
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

            Divider(),
            StreamBuilder<List<DoctorModel>>(
                stream: Provider.of<DoctorViewModel>(context,listen: false).getDoctorList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<DoctorModel>> asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    print("Hata: ${asyncSnapshot.error.toString()}");
                    return Center(
                      child: Text("Hata: ${asyncSnapshot.error.toString()}",
                          style: TextStyle(fontSize: 20)), // Hata mesajını yazdır
                    );
                  } else {
                    if (!asyncSnapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      // List<Map<String, dynamic>> mapDoctorList =
                      //     List<Map<String, dynamic>>.from(asyncSnapshot.data?.docs
                      //         as List<Map<String, dynamic>>);
                      List<DoctorModel>? documentList =
                          asyncSnapshot.data ;
                      return Flexible(
                          child: ListView.builder(
                              itemCount: documentList?.length,
                              itemBuilder: (context, index) {
                                // Map<String, dynamic> data = documentList?[index]
                                //      as Map<String, dynamic>;
                                DoctorModel? currentDoctor = documentList?[index];
                                if (currentDoctor == null) return Container();
                                return Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (_) {
                                    // documentList[index].reference.delete();
                                    // documentList[index].reference.update({"name":FieldValue.delete()});

                                    print(documentList?[index].name);
                                    print(currentDoctor.name);
                                  },
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    color: Colors.red,
                                    child:Icon(Icons.delete, color: Colors.white),
                                  ),
                                  child: Card(
                                    child: ListTile(
                                      title: Text("${currentDoctor.department}"),//Text(data["department"]),
                                      subtitle: Text(
                                          "Adı: ${currentDoctor.name} No: ${currentDoctor.no}"),//Text("Adı: ${data["name"]} No: ${data["no"]}"),
                                    ),
                                  ),
                                );
                              }));
                      // var documentSnapshot = asyncSnapshot.data;
                      // var mapData = Map<String, dynamic>.from(documentSnapshot?.data() as Map<String, dynamic>);
                      // return Text("${mapData["department"]}");
                    }

                    // print("streamden veri geldi ve Builder fonksiyonu çalıştırıldı");
                    // return Text("StreamBuilder");
                  }
                }),
            //ElevatedButton(onPressed: () async {await firestoreGet(firstDoctorRef, doctorRef);}, child: Text("Veri Çek"))

            // Diğer widget'lar buraya eklenebilir
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              // DocumentReference addedDoctor = await doctorRef.add(doctortoAdd);
              // print(addedDoctor.id);
              //await doctorRef.doc("doktorCivanım").set(doctorAdd);
              //await doctorRef.doc("doktorCivanım").update({"no": "46"});
              // await database.collection("favCaracters").doc("Harry Potter").set({
              //   "department": "gryffindor",
              //   "name": "Hayri Çömlekçi",
              //   "Asa ağacı": "çobanpüskülü ağacı"
              // });
            },
            child: Icon(Icons.add)),
      ),
    );
  }

  Future<void> firestoreGet(DocumentReference<Object?> firstDoctorRef,
      CollectionReference<Object?> doctorRef) async {
    DocumentSnapshot documentSnapshot = await firstDoctorRef.get();
    Object? data = documentSnapshot.data();
    print(data);
    Map<String, dynamic> datatwo = Map<String, dynamic>.from(
        documentSnapshot.data() as Map<String, dynamic>);
    if (data is Map<String, dynamic>) {
      print(data['department']);
    }
    print("datatwo = ${datatwo["department"]}");
    //koleksiyon referansı ile get kullanımı
    QuerySnapshot collectionSnapshot = await doctorRef.get();
    List<DocumentSnapshot> docs = collectionSnapshot.docs;
    print(docs.length);
    print(docs[1].data());
    docs.forEach((element) {
      Map<String, dynamic> datatwo =
          Map<String, dynamic>.from(element.data() as Map<String, dynamic>);
      print("datatwo element = ${datatwo["department"]}");
    });
  }
}
