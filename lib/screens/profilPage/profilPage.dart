import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  static String routeName = "ProfilPage";
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(),
    );
  }
}
