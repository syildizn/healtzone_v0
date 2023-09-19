import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  FirebaseFirestore firestore =FirebaseFirestore.instance;
//firestore servisinden verileri stream olarak alıp sağlamak

  Stream<QuerySnapshot<Map<String, dynamic>>> getDoctorListFromApi(String referencePath){
  return firestore.collection(referencePath).snapshots();
}

//firestore üzerindeki bir veriyi silme




//firestore'a yeni veri ekleme ve güncelleme
}