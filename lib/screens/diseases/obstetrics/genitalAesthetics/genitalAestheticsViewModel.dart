import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:healtzone_v0/screens/models/diseasesModels/obstetricsModels/genitalAestheticsModel.dart';

import '../../../../services/authentication.dart';
import '../../../../services/database.dart';

class GenitalAestheticsViewModel extends ChangeNotifier{
  Database database = Database();
  // String CollectionPathDoctor = "doctors";
  Authentication auth = Authentication();
  User? user;
  String? nameSurname;
  String? birthDay;
  String? phone;
  String? address;
  String? city;
  String? sex;
  String? userId;

  Future<void> getUserData() async {
    user = await auth.firebaseAuthen.currentUser;
    print("aradığım id preBirth: ${user?.uid}");
    if (user != null) {
      DocumentSnapshot? documentSnapshot =
      await database.readPatientData(user!.uid);

      if (documentSnapshot != null) {
        nameSurname = documentSnapshot['name'];
        birthDay = documentSnapshot['birthDay'];
        phone = documentSnapshot['phone'];
        address = documentSnapshot['address'];
        city = documentSnapshot['city'];
        sex = documentSnapshot['sex'];
        userId = user?.uid.toString();

        notifyListeners(); // UI'da değişiklikleri yakalamak için
      }
    }
  }

  Future<void> genitalAest(
      bool? hadPreviousSurgery,
      String? desiredProcedure,
      String? otherProcedure,
      bool? hadProfessionalExamination,
      String? recommendedProcedure,
      ) async {
    GenitalAestheticsModel genitalModel =GenitalAestheticsModel(
      userId: userId,
      id: '',
      sex: sex,
      city: city,
      name: nameSurname,
      address: address,
      birthDay: birthDay,
      hadPreviousSurgery: hadPreviousSurgery,
      desiredProcedure: desiredProcedure,
      hadProfessionalExamination:hadProfessionalExamination,
      otherProcedure:otherProcedure,
      recommendedProcedure:recommendedProcedure,
    );

    await database.setGenitalAestData(genitalModel.toJson());
  }

}