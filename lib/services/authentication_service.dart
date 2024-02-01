import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService extends GetxService {
  late FirebaseAuth _firebaseAuth;

  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    _firebaseAuth = FirebaseAuth.instance;
    currentUser.value = _firebaseAuth.currentUser;
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        currentUser.value = null;
      } else {
        currentUser.value = user;
      }
    });
  }

  FutureOr<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  void dispose() {
    currentUser.close();
  }

  FutureOr<String> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Error";
    }
  }

  FutureOr<String> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Error";
    }
  }

  FutureOr<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
