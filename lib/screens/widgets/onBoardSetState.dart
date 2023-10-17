import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/loginPage/loginPage.dart';
import 'package:healtzone_v0/screens/homePage/publications.dart';

class OnBoardSetState extends StatefulWidget {
  //Başlangıçta kullanıcının daha önce giriş yapıp yapmadığını kontrol eden widget
  static String routeName = "OnBoardSetState";
  const OnBoardSetState({Key? key}) : super(key: key);

  @override
  State<OnBoardSetState> createState() => _OnBoardSetStateState();
}

class _OnBoardSetStateState extends State<OnBoardSetState> {

  bool? isLogged;

  @override
  void initState() {
    // TODO: implement initState

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        isLogged= false;
        print('User is currently signed out!');
      } else {
        isLogged= true;
        print('User is signed in!');
      }

      setState(() { });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //aşağıda kullanıcı girişi true ise ana sayfaya yönlendiren ama false ise giriş sayfasına yönlendiren kod var.
    //return isLogged == null?Center(child: CircularProgressIndicator()):isLogged?PublicationsScreen():LoginPage();
    return isLogged == true?PublicationsScreen():isLogged == false?LoginPage():Center(child: CircularProgressIndicator());
  }
}
// class _OnBoardState extends State<OnBoard> {
//   //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     final authen = Provider.of<Authentication>(context, listen: false);
//
//     return StreamBuilder<User?>(
//         stream: authen.authenStatus(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//
//           if(snapshot.connectionState == ConnectionState.active){
//             return snapshot.data != null?PublicationsScreen():LoginPage();
//           }else{
//             return SizedBox(height: 300,width: 300,child: CircularProgressIndicator(),);
//           }
//
//
//         });
//   }
// }