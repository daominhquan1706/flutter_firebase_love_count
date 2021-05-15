import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  //Set up SingleTon
  static AuthenticationService get instance => _instance;
  AuthenticationService._privateConstructor();
  static final AuthenticationService _instance =
      AuthenticationService._privateConstructor();

  FirebaseAuth _firebaseAuth;
  void setFirebaseAuth(FirebaseAuth firebaseAuth) {
    _firebaseAuth = firebaseAuth;
  }

  StreamController authStateController = new StreamController<UserApp>();
  //Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  Stream<UserApp> get authStateChanges => authStateController.stream;
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  void dispose() {
    authStateController.close();
  }

  void changeAuthState(UserApp user) {
    authStateController.sink.add(user);
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
