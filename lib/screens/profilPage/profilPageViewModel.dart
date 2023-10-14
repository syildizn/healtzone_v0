import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/services/authentication.dart';
import 'package:healtzone_v0/services/database.dart';
import 'package:provider/provider.dart';

class ProfilPageViewModel extends ChangeNotifier{
  Database database = Database();
  Authentication auth = Authentication();

  String? isimSoyisim;
  int? yas;
  String? telefon;
  String? adres;
  String? sehir;
  String? email;
  String? cinsiyet;

  Future<void> getUserData() async {
    User? user = await auth.firebaseAuthen.currentUser;
    print("aradığım id: ${user?.uid}");
    if (user != null) {
      DocumentSnapshot? documentSnapshot = await database.readPatientData(user.uid);

      if (documentSnapshot != null) {
        isimSoyisim = documentSnapshot['name'];
        yas = documentSnapshot['age'];
        telefon = documentSnapshot['phone'];
        adres = documentSnapshot['address'];
        sehir = documentSnapshot['city'];
        email = documentSnapshot['email'];
        cinsiyet = documentSnapshot['sex'];

        notifyListeners();  // UI'da değişiklikleri yakalamak için
      }
    }
  }

  // Future<DocumentSnapshot?> getUser() async{
  //   User? user = await auth.firebaseAuthen.currentUser;
  //
  //   if (user != null) {
  //     DocumentSnapshot? documentSnapshot = await database.readPatientData(user.uid);
  //     // DocumentSnapshot documentSnapshot = await _firestore
  //     //     .collection('patients')
  //     //     .doc(currentUser.uid)
  //     //     .get();
  //
  //   return documentSnapshot;
  // }
  //
  // Future<void> findUserInfo() async {}
  //
  // }


}