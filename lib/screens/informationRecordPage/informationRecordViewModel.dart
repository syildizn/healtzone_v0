import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/models/doctorModel.dart';
import 'package:healtzone_v0/services/database.dart';

class InfRecVievModel extends ChangeNotifier {
  Database database = Database();
  String CollectionPathDoctor = "doctors";

  Future<void> doctorUpdate(
      {String? name,
      String? department,
      String? companyName,
      String? address,
      String? title,
      String? phone,
      String? university,
      String? graduationYear,
      String? id,
      String? role,
      String? email}) async {

    DoctorModel updateDoctor = DoctorModel(
      role: role,
      id: id,
      email: email,
      phone: phone,
      name: name,
      graduationYear: graduationYear,
      department: department,
      companyName: companyName,
      address: address,
      title: title,
      university: university,
      completedProfile: true,
      verified: false,
    );
    await database.updateDoctorData(CollectionPathDoctor, updateDoctor.toJson());
    print("işlemleri yaptım $updateDoctor" );
  }
}
