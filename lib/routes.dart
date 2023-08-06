import 'package:flutter/cupertino.dart';
import 'package:healtzone_v0/screens/doctor.dart';
import 'package:healtzone_v0/screens/offers.dart';
import 'package:healtzone_v0/screens/publications.dart';

Map<String,WidgetBuilder> routes = {
 PublicationsScreen.routeName: (context) => PublicationsScreen(),
 Doctor.routeName: (context) => Doctor(),
 OffersPage.routeName:(context) => OffersPage(),
};