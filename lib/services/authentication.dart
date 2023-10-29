import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication{
   UserCredential? userLogin;
  final firebaseAuthen = FirebaseAuth.instance;


  Future<User?> signInAnonymously() async {
    final userCredentials = await firebaseAuthen.signInAnonymously();
    userLogin = userCredentials.user as UserCredential?;
    return userCredentials.user;
  }

  Future<User?> createUserWithEmailAndPassword(String email,String password) async {

    try{
      final userCredentials = await firebaseAuthen.createUserWithEmailAndPassword(email: email, password: password);
      return userCredentials.user;
    }
    on FirebaseAuthException catch(e){
      print(e.message);
      rethrow;
    }

  }

  Future<User?> signInWithEmailAndPassword(String email,String password) async {

    try{
      final userCredentials = await firebaseAuthen.signInWithEmailAndPassword(email: email, password: password);
    //userLogin = userCredentials.user as UserCredential?;
    //return userCredentials;
    return userCredentials.user;
    }on FirebaseAuthException catch(e){
      print(e.message);
      rethrow;
    }


  }

  Future<void> sendPasswordResetEmail(email)async {
    await firebaseAuthen.sendPasswordResetEmail(email: email);
  }



  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser != null){
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await firebaseAuthen.signInWithCredential(credential);
      //userLogin = userCredential.user as UserCredential?;
      return userCredential.user;
    }else{return null;}


  }


  Future<void> signOut() async {
    await firebaseAuthen.signOut();
    await GoogleSignIn().signOut();
  }

  Stream<User?> authenStatus(){

    return firebaseAuthen.authStateChanges();
  }

}