import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication{
  final firebaseAuthen = FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    final userCredentials = await firebaseAuthen.signInAnonymously();

    return userCredentials.user;
  }

  Future<User?> createUserWithEmailAndPassword(String email,String password) async {
    final userCredentials = await firebaseAuthen.createUserWithEmailAndPassword(email: email, password: password);

    return userCredentials.user;
  }

  Future<User?> signInWithEmailAndPassword(String email,String password) async {
    final userCredentials = await firebaseAuthen.signInWithEmailAndPassword(email: email, password: password);

    return userCredentials.user;
  }

  Future<void> sendPasswordResetEmail(email)async {
    await firebaseAuthen.sendPasswordResetEmail(email: email);
  }



  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await firebaseAuthen.signInWithCredential(credential);
    return userCredential.user;
  }


  Future<void> signOut() async {
    await firebaseAuthen.signOut();
  }

  Stream<User?> authenStatus(){
    return firebaseAuthen.authStateChanges();
  }

}