import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healtzone_v0/screens/models/doctorModel.dart';
import 'package:healtzone_v0/screens/models/patientProfile.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
//firestore servisinden verileri stream olarak alıp sağlamak

  Stream<QuerySnapshot<Map<String, dynamic>>> getDoctorListFromApi(
      String referencePath) {
    return firestore.collection(referencePath).snapshots();
  }

//firestore üzerindeki bir veriyi silme

  Future<void> deleteDocument(
      {required String referencePath, required String? id}) async {
    firestore.collection(referencePath).doc(id).delete();
  }

//firestore'a yeni veri ekleme ve güncelleme

  Future<void> setDoctorData(//firestore'a ilk kayıt sırasında doctor koleksiyonunda kullanıcı oluşturma
      String collectionPath, Map<String, dynamic> doctorAsMap) async {
    await firestore
        .collection(collectionPath)
        .doc(DoctorModel.fromJson(doctorAsMap).id)
        .set(doctorAsMap);
  }

  Future<void> updateDoctorData( // doctor kullanıcısının ilk kayıttan sonra bilgilerini dolduracağı yeri firestore'a yazma
      String collectionPath, Map<String, dynamic> doctorUpAsMap) async {
    await firestore
        .collection(collectionPath)
        .doc(DoctorModel.fromJson(doctorUpAsMap).id)
        .update(doctorUpAsMap);
  }

  Future<void> setPatientData(//firestore'a ilk kayıt sırasında doctor koleksiyonunda kullanıcı oluşturma
      String collectionPath, Map<String, dynamic> patientAsMap) async {
    await firestore
        .collection(collectionPath)
        .doc(PatientModel.fromJson(patientAsMap).id)
        .set(patientAsMap);

  }


  Future<DocumentSnapshot?> readPatientData(String userUid) async {
    DocumentSnapshot x = await firestore.collection("patients").doc(userUid).get();
    print("aha bu email: ${x['email']}");
    return x;
  }

  Stream<DocumentSnapshot> readPatientDataStream(String userUid) {
    return firestore.collection("patients").doc(userUid).snapshots();
  }



  Future<void> updatePatientData(//firestore'a ilk kayıt sırasında doctor koleksiyonunda kullanıcı oluşturma
      String collectionPath, Map<String, dynamic> patientUpAsMap) async {
    await firestore
        .collection("patients")
        .doc(PatientModel.fromJson(patientUpAsMap).id)
        .update(patientUpAsMap);
  }

  // Future<void> setPreAndBirthData(//firestore'a ilk kayıt sırasında doctor koleksiyonunda kullanıcı oluşturma
  //      Map<String, dynamic> preAndBirthAsMap) async {
  //   await firestore
  //       .collection('jobs')
  //       .doc('ObstetricsAndGynaecology').collection('preAndBirth').add(preAndBirthAsMap);
  // }

  Future<void> setPreAndBirthData(Map<String, dynamic> preAndBirthAsMap) async {
    DocumentReference docRef = firestore
        .collection('jobs')
        .doc('ObstetricsAndGynaecology')
        .collection('preAndBirth')
        .doc();  // Bu satır yeni bir doküman referansı oluşturur ve bir ID atar.

    preAndBirthAsMap['id'] = docRef.id;  // ID'yi haritaya ekler.

    await docRef.set(preAndBirthAsMap);  // Dokümanı oluşturur ve verileri ayarlar.
  }

}
