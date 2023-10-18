import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/models/patientProfile.dart';

import '../../services/database.dart';

class PatLogAndSgnViewModel extends ChangeNotifier{
  Database database = Database();
  String collectionPathPatient = 'patients';

  Future<void> addNewPatient({String? id,  String? email}) async {
    // kayıt kısmından aldığı id ve role ile bir doctor objesi oluşturacak

    try{
      PatientModel newPatient = PatientModel(
        id: id,
        email: email,
        address: null,
        name: null,
        age: null,
        city: null,
        sex: null,
        completedProfile: false,
        phone: null,

      );

     // bu doctor bilgisini database servisi üzerinden Firestore'a yazacak
     await database.setPatientData(collectionPathPatient, newPatient.toJson());
    }catch(e){print("hataModel: $e");}

  }

}