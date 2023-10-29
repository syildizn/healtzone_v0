import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:healtzone_v0/screens/models/diseasesModels/obstetricsModels/surgeriesModel.dart';
import 'package:path/path.dart' as p;  // <- Bu satırı ekleyin
import '../../../../services/authentication.dart';
import '../../../../services/database.dart';
import '../../../../services/storage.dart';

class SurgeriesViewModel extends ChangeNotifier{
  Database database = Database();
  // String CollectionPathDoctor = "doctors";
  Storage storage = Storage();
  String? photUrl;
  String? photUrlDownl;
  String? fileUrlDownl;
  Authentication auth = Authentication();
  User? user;
  String? nameSurname;
  String? birthDay;
  String? phone;
  String? address;
  String? city;
  String? sex;
  String? userId;
  String? picPath;
  String? filePath;
  String? selectedFileName;
  String? selectedImageName;

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


  Future<void> surgeries(
      bool? hadPreviousSurgery,
      String? diagnosis,
      String? medicalInfo,
      bool? hasMedicalInfo,
      String? pathologyResults,
      String? selectedSurgery,
      String? surgeryType,

      ) async {

    SurgeriesModel surgeryModel = SurgeriesModel(
      userId: userId,
      id: '',
      sex: sex,
      city: city,
      name: nameSurname,
      address: address,
      birthDay: birthDay,
      diagnosis: diagnosis,
      filePath: filePath,
      hadPreviousSurgery: hadPreviousSurgery,
      hasMedicalInfo: hasMedicalInfo,
      medicalInfo: medicalInfo,
      pathologyResults: pathologyResults,
      picPath: picPath,
      selectedSurgery: selectedSurgery,
      surgeryType: surgeryType,

    );

    await database.setSurgeriesData(surgeryModel.toJson());
  }

  Future<void> uploadImage (File imageFile) async {
    picPath = await storage.uploadImageToStorege(imageFile);
    selectedImageName = p.basename(imageFile.path);  // Resim adını güncelle
    notifyListeners();  // UI'yi güncelle
    print("uploadedImage ViewModelInVitro çalıştı link:$picPath ");
  }

  Future<void> uploadFile(File file) async {
    filePath = await storage.uploadFileToStorage(file);
    selectedFileName = p.basename(file.path);  // Dosya adını güncelle
    notifyListeners();  // UI'yi güncelle
    print("UploadedFile ViewModelInVitro worked link:$filePath");
  }

}