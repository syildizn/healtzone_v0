import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/services/authentication.dart';
import 'package:healtzone_v0/services/database.dart';
import 'package:healtzone_v0/services/storage.dart';
//import 'package:provider/provider.dart';

class ProfilPageViewModel extends ChangeNotifier{
  Database database = Database();
  Authentication auth = Authentication();
  //StreamSubscription? _subscription;
  Storage storage = Storage();


  String? isimSoyisim;
  String? dogumTarihi;
  String? telefon;
  String? adres;
  String? sehir;
  String? email;
  String? cinsiyet;

  // Future<void> getUserData() async {
  //   User? user = await auth.firebaseAuthen.currentUser;
  //   print("aradığım id: ${user?.uid}");
  //   if (user != null) {
  //     DocumentSnapshot? documentSnapshot = await database.readPatientData(user.uid);
  //
  //     if (documentSnapshot != null) {
  //       isimSoyisim = documentSnapshot['name'];
  //       yas = documentSnapshot['age'];
  //       telefon = documentSnapshot['phone'];
  //       adres = documentSnapshot['address'];
  //       sehir = documentSnapshot['city'];
  //       email = documentSnapshot['email'];
  //       cinsiyet = documentSnapshot['sex'];
  //
  //       notifyListeners();  // UI'da değişiklikleri yakalamak için
  //     }
  //   }
  // }

  // void listenUserData() {
  //   User? user = auth.firebaseAuthen.currentUser;
  //   print("aradığım id: ${user?.uid}");
  //   if (user != null) {
  //     _subscription =  database.readPatientDataStream(user.uid).listen((documentSnapshot) {
  //       isimSoyisim = documentSnapshot['name'];
  //       yas = documentSnapshot['age'];
  //       telefon = documentSnapshot['phone'];
  //       adres = documentSnapshot['address'];
  //       sehir = documentSnapshot['city'];
  //       email = documentSnapshot['email'];
  //       cinsiyet = documentSnapshot['sex'];
  //
  //       notifyListeners();  // UI'da değişiklikleri yakalamak için
  //     });
  //   }
  // }


// Eğer widget ağacından bu ViewModel'i kaldırıyorsanız, aboneliği iptal etmelisiniz.
//   void dispose() {
//     _subscription?.cancel();
//     super.dispose();
//   }

  Stream<DocumentSnapshot> listenUserData() {
    User? user = auth.firebaseAuthen.currentUser;
    print("aradığım id: ${user?.uid}");
    if (user != null) {
      return database.readPatientDataStream(user.uid);
    } else {
      // Kullanıcı bulunamazsa, boş bir stream döndür.
      return Stream.empty();
    }
  }

  Future<String?> getImage () async {
    String? imageUrl;
    imageUrl = await storage.storegeExample();
    print("ProfilPage avatar ViewModel link: $imageUrl");
    return imageUrl;
  }

  Future<void> uploadImage (File imageFile) async {
    await storage.uploadImageToStorege(imageFile);
    print("uploadedImage ViewModel çalıştı");
  }

}