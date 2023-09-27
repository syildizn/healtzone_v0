import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/models/patientProfile.dart';

import '../../services/database.dart';
import '../models/doctorModel.dart';

class LoginPageViewModel extends ChangeNotifier{
  Database database = Database();
  String collectionPathDoctor = 'doctors';
  String collectionPathPatient = 'patients';

  Future<void> addNewDoctor({String? id,  String? email}) async {
    // kayıt kısmından aldığı id ve role ile bir doctor objesi oluşturacak


    DoctorModel newDoctor = DoctorModel(
        id: id,
        university: null,
        title: null,
        address: null,
        companyName: null,
        completedProfile: false,
        department: null,
        email: email,
        graduationYear: null,
        name: null,
        phone: null,
        verified: false
    );



    // bu doctor bilgisini database servisi üzerinden Firestore'a yazacak
    await database.setDoctorData(collectionPathDoctor, newDoctor.toJson());

  }

  Future<void> addNewPatient({String? id, String? email}) async{
    try{  PatientModel newPatient = PatientModel(
        id: id,
        email: email,
        phone: null,
        name: null,
        address: null,
        age: null,
        city: null,
        sex: null,
        completedProfile: false

    );

    // bu doctor bilgisini database servisi üzerinden Firestore'a yazacak
    await database.setPatientData(collectionPathPatient, newPatient.toJson());}catch(e){
      print("hata $e");
    }


  }
}