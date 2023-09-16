import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/publications.dart';

import 'offers.dart';

class Doctor extends StatefulWidget {
  static String routeName = "DoctorPage";
  const Doctor({Key? key}) : super(key: key);

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  final FirebaseFirestore database = FirebaseFirestore.instance;

  int currentPage = 2; //  1: İlanlarım, 2: Doktor Bul, 3: Teklifler
  @override
  Widget build(BuildContext context) {
    final CollectionReference doctorRef = database.collection("doctors");
    final DocumentReference firstDoctorRef =
        doctorRef.doc("A3B9N0uzRlHZFgIHUkfH");

    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("${firstDoctorRef.id}"),
          ),
          Divider(),
          StreamBuilder(
              stream: doctorRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  return Center(
                    child: ErrorWidget(Error()),
                  );
                } else {
                  if (!asyncSnapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    // List<Map<String, dynamic>> mapDoctorList =
                    //     List<Map<String, dynamic>>.from(asyncSnapshot.data?.docs
                    //         as List<Map<String, dynamic>>);
                    List<DocumentSnapshot> documentList =
                    asyncSnapshot.data?.docs as List<DocumentSnapshot>;
                    return Flexible(
                        child: ListView.builder(
                            itemCount: documentList.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data =
                              documentList[index].data() as Map<String, dynamic>;
                              return Card(
                                child: ListTile(
                                  title: Text(data["department"]),
                                  subtitle:Text("Adı: ${data["name"]} No: ${data["no"]}") ,

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
              })
          //ElevatedButton(onPressed: () async {await firestoreGet(firstDoctorRef, doctorRef);}, child: Text("Veri Çek"))

          // Diğer widget'lar buraya eklenebilir
        ],
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
