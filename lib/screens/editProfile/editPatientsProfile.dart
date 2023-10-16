import 'package:flutter/material.dart';

class EditPatientsProfile extends StatefulWidget {
  static String routeName = "ProfilPage";
  const EditPatientsProfile({Key? key}) : super(key: key);

  @override
  State<EditPatientsProfile> createState() => _EditPatientsProfileState();
}

class _EditPatientsProfileState extends State<EditPatientsProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Profil Düzenle"), backgroundColor: Colors.blue.shade400),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.white],
          ),
        ),
        child: Column(),
      ),
    );
  }
}
