import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth;

  Auth({required this.auth});

  Stream<User> get user => auth.authStateChanges();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<String> createAccount({
    required String email,
    required String password,
    required String name,
    required String surname,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      await users.add({
        'name': name.trim(),
        'surname': surname.trim(),
        'mail': email.trim(),
        'password': password.trim(),
      });
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> SignIn(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> SignOut(
      {required String email, required String password}) async {
    try {
      await auth.signOut();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }
}
