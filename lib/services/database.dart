import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  FirebaseFirestore firestore =FirebaseFirestore.instance;
//firestore servisinden verileri stream olarak alıp sağlamak

  Stream<QuerySnapshot<Map<String, dynamic>>> getDoctorListFromApi(String referencePath){
  return firestore.collection(referencePath).snapshots();
}

//firestore üzerindeki bir veriyi silme

Future<void> deleteDocument({required String referencePath, required String? id})async {
  firestore.collection(referencePath).doc(id).delete();
}


//firestore'a yeni veri ekleme ve güncelleme
}