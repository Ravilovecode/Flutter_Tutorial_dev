import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/dashboard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:globalchat/screens/splash_screen.dart';

class SignupController {
  static Future<void> createAccount({
    required String email,
    required String password,
    required BuildContext context,
    required String name,
    required String country,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var userId = FirebaseAuth.instance.currentUser!.uid;
      var db = FirebaseFirestore.instance;
      try {
        await db.collection("users").doc(userId.toString()).set({
          "name": name,
          "email": email,
          "country": country,
          "id": userId.toString(),
        });
      } catch (error) {
        print(error);
      }

      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => SplashScreen()),
          (route) {
        return false;
      });

      print("Account created successfully");
    } catch (e) {
      SnackBar messageSnackBAr =
          SnackBar(backgroundColor: Colors.red, content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBAr);
      print(e);
    }
  }
}
