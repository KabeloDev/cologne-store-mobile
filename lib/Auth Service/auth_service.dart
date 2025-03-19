import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
 
  final _auth = FirebaseAuth.instance;


  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }

  Future<User?> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Signing in user went wrong");
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Signing out user went wrong");
    }
  }
}
