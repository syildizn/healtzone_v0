import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  final firebaseAuthen = FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    final userCredentials = await firebaseAuthen.signInAnonymously();

    return userCredentials.user;
  }

}