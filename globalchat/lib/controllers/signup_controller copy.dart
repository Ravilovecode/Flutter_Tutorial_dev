import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/dashboard_screen.dart';

class SignupController {
  static Future<void> createAccount(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()),
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
