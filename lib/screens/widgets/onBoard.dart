import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/loginPage.dart';
import 'package:healtzone_v0/screens/publications.dart';
import 'package:healtzone_v0/services/authentication.dart';
import 'package:provider/provider.dart';

class OnBoard extends StatefulWidget {
  //Başlangıçta kullanıcının daha önce giriş yapıp yapmadığını kontrol eden widget
  static String routeName = "OnBoard";
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

  @override
  Widget build(BuildContext context) {
    final authen = Provider.of<Authentication>(context, listen: false);

    return StreamBuilder<User?>(
        stream: authen.authenStatus(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if(snapshot.connectionState == ConnectionState.active){
            return snapshot.data != null?PublicationsScreen():LoginPage();
          }else{
            return SizedBox(height: 300,width: 300,child: CircularProgressIndicator(),);
          }


        });
  }
}
