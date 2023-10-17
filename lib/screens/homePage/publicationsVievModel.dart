import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../services/authentication.dart';
import '../../services/database.dart';

class PublicationsViewModel extends ChangeNotifier{
  Database database = Database();
  Authentication auth = Authentication();
  User? user;
  bool? completedProfile;

  Future<void> getUserData() async {
    user = await auth.firebaseAuthen.currentUser;
    print("aradığım id: ${user?.uid}");
    if (user != null) {
      DocumentSnapshot? documentSnapshot = await database.readPatientData(user!.uid);

      if (documentSnapshot != null) {
        completedProfile = documentSnapshot['completedProfile'];
        notifyListeners();  // UI'da değişiklikleri yakalamak için
      }
    }
  }
}