import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:gbesoin/providers/local_storage.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  Future<String?> signIn(LoginData data) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: data.name.toString(), password: data.password.toString());
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp(SignupData data) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: data.name.toString(),
        password: data.password.toString(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    LocalStorage().setToNullIdGroup();
    await _auth.signOut();
  }

  Future<String?> recoverPassword(String name) async {
    try {
      await _auth.sendPasswordResetEmail(email: name);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> getUserId() async {
    return _auth.currentUser?.getIdToken().toString();
  }
}
