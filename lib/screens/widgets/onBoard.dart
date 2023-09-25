import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/loginPage.dart';
import 'package:healtzone_v0/screens/models/doctorModel.dart';
import 'package:healtzone_v0/screens/publications.dart';
import 'package:healtzone_v0/services/authentication.dart';
import 'package:provider/provider.dart';

import '../informationRecordPage/informationRecord.dart';
import '../waitingPage.dart';

class OnBoard extends StatefulWidget {
  //Başlangıçta kullanıcının daha önce giriş yapıp yapmadığını kontrol eden widget
  static String routeName = "OnBoard";
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
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

class _OnBoardState extends State<OnBoard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final authen = Provider.of<Authentication>(context, listen: false);

    return StreamBuilder<User?>(
      stream: authen.authenStatus(),
      builder: (BuildContext context, AsyncSnapshot<User?> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.active) {
          User? user = userSnapshot.data;


          if (user != null) {
            // Kullanıcı giriş yapmış. Hangi role sahip olduğunu kontrol edelim.
            return StreamBuilder<DocumentSnapshot>(
              stream:
                  _firestore.collection('doctors').doc(user.uid).snapshots(),
              builder: (context, doctorSnapshot) {
                if (doctorSnapshot.hasData) {
                  if (doctorSnapshot.data!.exists) {
                    // Kullanıcı bir doktor.
                    return profileCheck(doctorSnapshot,
                        FormValidInfo.doctorInfo, PublicationsScreen());
                  } else {
                    // Kullanıcı bir hasta olabilir. Hasta koleksiyonundan kontrol edelim.
                    return StreamBuilder<DocumentSnapshot>(
                        stream: _firestore
                            .collection('patients')
                            .doc(user.uid)
                            .snapshots(),
                        builder: (context, patientSnapshot) {
                          if (patientSnapshot.hasData) {
                            if (patientSnapshot.data!.exists) {
                              // Kullanıcı bir hasta.
                              return profileCheck(
                                  patientSnapshot,
                                  FormValidInfo.patientInfo,
                                  PublicationsScreen());
                            } else {
                              // Kullanıcı ne doktor ne de hasta koleksiyonlarında. Bir hata döndürebilirsiniz.
                              return Scaffold(
                                  appBar: AppBar(actions: [
                                    IconButton(
                                        onPressed: () async {
                                          await Provider.of<Authentication>(
                                                  context,
                                                  listen: false)
                                              .signOut();
                                        },
                                        icon: Icon(Icons.exit_to_app))
                                  ]),
                                  body: Center(
                                      child: CircularProgressIndicator()));
                              ; // Bu bir örnek. Böyle bir ekranınızın olup olmadığını kontrol edin.
                            }
                          }
                          return Scaffold(
                              body: Center(child: CircularProgressIndicator()));
                        });
                  }
                }
                return Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              },
            );
          } else {
            // Kullanıcı giriş yapmamış.
            return LoginPage();
          }
        }
        return SizedBox(
            height: 300, width: 300, child: CircularProgressIndicator());
      },
    );
  }

  Widget profileCheck(AsyncSnapshot<DocumentSnapshot> snapshot,
      FormValidInfo info, Widget mainPage) {
    if (snapshot.data!.get('completedProfile') == true) {

      if(snapshot.data!.get('verified') == true) {
        return mainPage;
      }else {
        return WaitingPage() ;
      } // Profili tamamlanmış.
    } else {
      print("info aha bu: $info");
      return InformationRecord(
        formValidInfo: info,
        snapshot: snapshot,
      ); // Profil bilgilerini tamamla sayfasına yönlendir.
    }
  }
}

//
//     // return StreamBuilder<User?>(
//     //     stream: authen.authenStatus(),
//     //     builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//     //       if (snapshot.connectionState == ConnectionState.active) {
//     //         User? user = snapshot.data;
//     //         if (user != null) {
//     //           // Kullanıcı giriş yapmış, Firestore'dan kullanıcı verilerini kontrol edelim
//     //           return StreamBuilder<DocumentSnapshot>(
//     //             stream: _firestore.collection('doctors').doc(user.uid).snapshots(),
//     //             builder: (context, snapshot) {
//     //               if (snapshot.hasData) {
//     //                 if (snapshot.data!.exists) {
//     //                   if (snapshot.data!.get('completedProfile') == true) {
//     //                     // Kullanıcı profili tamamlanmış, ana sayfaya yönlendir.
//     //                     return PublicationsScreen();
//     //                   } else {
//     //                     // Kullanıcı profili tamamlanmamış, bilgi girişi sayfasına yönlendir.
//     //                     return InformationRecord(formValidInfo: FormValidInfo.doctorInfo);
//     //                   }
//     //                 } else {
//     //                   // Bu kullanıcı için Firestore'da veri yok, bilgi girişi sayfasına yönlendir.
//     //                   return InformationRecord(formValidInfo: FormValidInfo.doctorInfo);
//     //                 }
//     //               } else {
//     //                 // Bekleme ekranı veya bir hata ekranı döndürebilirsiniz.
//     //                 return CircularProgressIndicator();
//     //               }
//     //             },
//     //           );
//     //         } else {
//     //           // Kullanıcı giriş yapmamış, giriş sayfasına yönlendir.
//     //           return LoginPage();
//     //         }
//     //       } else {
//     //         // Bekleme ekranı.
//     //         return SizedBox(height: 300, width: 300, child: CircularProgressIndicator());
//     //       }
//     //     });
//
//
//
//   }
// }
