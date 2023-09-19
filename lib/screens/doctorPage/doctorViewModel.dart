import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/models/doctorModel.dart';
import 'package:healtzone_v0/services/database.dart';

class DoctorViewModel extends ChangeNotifier {
  // doctorPage'in(doctor.dart) state bilgisini tutmak
  //doctorPage(doctor.dart) arayüzü olan metotları ve hesaplamaları yapmak
  //gerekli servislerle konuşmak

  Database database = Database();

  Stream<List<DoctorModel>> getDoctorList() {
    const String doctorRef = "doctors";
    //stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument = database
        .getDoctorListFromApi(doctorRef)
        .map((QuerySnapshot) => QuerySnapshot.docs );

    //stream<List<DocumentSnapshot>> --> Stream<List<DoctorModel>>
    Stream<List<DoctorModel>> streamListDoctor = streamListDocument.map(
        (listOfDocSnap) => listOfDocSnap
            .map((docSnap) => DoctorModel.fromJson(docSnap.data()  as Map<String, dynamic>)).toList() );
    return streamListDoctor;
  }
}
