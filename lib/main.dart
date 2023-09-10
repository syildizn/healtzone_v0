import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/routes.dart';
import 'package:healtzone_v0/screens/loginPage.dart';
import 'package:healtzone_v0/screens/publications.dart';
import 'package:healtzone_v0/screens/widgets/onBoard.dart';
import 'package:healtzone_v0/services/authentication.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<Authentication>(
      create: (context) => Authentication(),
      child: MaterialApp(
        title: 'HealthZone',
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: OnBoard.routeName,
      ),
    );
  }
}

