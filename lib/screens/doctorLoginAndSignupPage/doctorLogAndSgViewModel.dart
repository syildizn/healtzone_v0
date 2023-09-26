import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/models/doctorModel.dart';
import 'package:healtzone_v0/services/database.dart';
import 'package:provider/provider.dart';

class DocLgAndSgVievModel extends ChangeNotifier{
 Database database = Database();
 String collectionPathDoctor = 'doctors';
 String collectionPathPatient = 'patients';
 Future<void> addNewDoctor({String? id, String? role, String? email}) async {
   // kayıt kısmından aldığı id ve role ile bir doctor objesi oluşturacak


   DoctorModel newDoctor = DoctorModel(
     id: id,
     role: role,
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

}