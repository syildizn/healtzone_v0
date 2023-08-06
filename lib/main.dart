import 'package:flutter/material.dart';
import 'package:healtzone_v0/routes.dart';
import 'package:healtzone_v0/screens/publications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthZone',
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: PublicationsScreen.routeName,
    );
  }
}

