import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/models/patientProfile.dart';
import 'package:healtzone_v0/services/authentication.dart';
import 'package:healtzone_v0/services/database.dart';
import 'package:provider/provider.dart';

class EditPatientsProfilViewModel extends ChangeNotifier{
  Database database = Database();
  Authentication auth = Authentication();
  User? user;
  String? nameSurname;
  int? age;
  String? phone;
  String? address;
  String? city;
  String? sex;

  Future<void> getUserData() async {
    user = await auth.firebaseAuthen.currentUser;
    print("aradığım id: ${user?.uid}");
    if (user != null) {
      DocumentSnapshot? documentSnapshot = await database.readPatientData(user!.uid);

      if (documentSnapshot != null) {

        nameSurname = documentSnapshot['name'];
        age = documentSnapshot['age'];
        phone = documentSnapshot['phone'];
        address = documentSnapshot['address'];
        city = documentSnapshot['city'];
        sex = documentSnapshot['sex'];

        notifyListeners();  // UI'da değişiklikleri yakalamak için
      }
    }
  }

  Future<void> patientsUpdate(
      {String? name,
        int? age,
        String? sex,
        String? address,
        String? city,
        String? phone,
       }) async {

      PatientModel patientModel = PatientModel(
        id: user?.uid.toString(),
        name: name,
        sex: sex,
        city: city,
        age: age,
        address: address,
        phone: phone
      );
    await database.updatePatientData("patients", patientModel.toJson());
    print("işlemleri yaptım $patientModel" );
  }
}

