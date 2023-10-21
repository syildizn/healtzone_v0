import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:healtzone_v0/screens/models/diseasesModels/obstetricsModels/preAndBirthModel.dart';
import '../../../../services/authentication.dart';
import '../../../../services/database.dart';

class PreAndBirthViewModel extends ChangeNotifier {
  Database database = Database();
  // String CollectionPathDoctor = "doctors";
  Authentication auth = Authentication();
  User? user;
  String? nameSurname;
  String? age;
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
        age = documentSnapshot['age'];
        phone = documentSnapshot['phone'];
        address = documentSnapshot['address'];
        city = documentSnapshot['city'];
        sex = documentSnapshot['sex'];
        userId = user?.uid.toString();

        notifyListeners(); // UI'da değişiklikleri yakalamak için
      }
    }
  }

  Future<void> preAndBirth(
    bool? previousBirth,
    String? cesarianSection,
    String? pregnancyWeek,
    bool? pregnancyInfoYesNo,
    String? pregnancyInfo,
    String? neededService,
  ) async {
    PreAndBirthModel preModel = PreAndBirthModel(
      id: '',
      sex: sex,
      city: city,
      birthDay: age,
      name: nameSurname,
      address: address,
      cesarianSection: cesarianSection,
      neededService: neededService,
      pregnancyInfo: pregnancyInfo,
      pregnancyInfoYesNo: pregnancyInfoYesNo,
      pregnancyWeek: pregnancyWeek,
      previousBirth: previousBirth,
      userId: userId,
    );

   await database.setPreAndBirthData(preModel.toJson());
  }
}
