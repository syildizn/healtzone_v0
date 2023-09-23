import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healtzone_v0/screens/models/doctorModel.dart';

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

Future<void> setDoctorData(String collectionPath,Map<String, dynamic> doctorAsMap) async {
    await firestore.collection(collectionPath).doc(DoctorModel.fromJson(doctorAsMap).id).set(doctorAsMap);
}

}