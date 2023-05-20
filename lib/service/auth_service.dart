import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_cuoi_ki/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SignIn
  Future<User?> signIn(String email, String password) async{
    var user =  await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  //SignOut
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }


  //Register
  Future<User?> createUser(String name, String email, String password, String photoURL) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore
        .collection("users")
        .doc(user.user!.uid)
        .set({'userName': name, 'email': email, 'photoURL': photoURL});

    return user.user;
  }
}