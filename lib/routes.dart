import 'package:flutter/cupertino.dart';
import 'package:healtzone_v0/screens/doctor.dart';
import 'package:healtzone_v0/screens/loginPage.dart';
import 'package:healtzone_v0/screens/offers.dart';
import 'package:healtzone_v0/screens/publications.dart';
import 'package:healtzone_v0/screens/widgets/onBoard.dart';
import 'package:healtzone_v0/screens/widgets/onBoardSetState.dart';

Map<String,WidgetBuilder> routes = {
 PublicationsScreen.routeName: (context) => PublicationsScreen(),
 Doctor.routeName: (context) => Doctor(),
 OffersPage.routeName:(context) => OffersPage(),
 LoginPage.routeName: (context) => LoginPage(),
 OnBoard.routeName:(context) => OnBoard(),
 OnBoardSetState.routeName:(context) => OnBoardSetState(),
};