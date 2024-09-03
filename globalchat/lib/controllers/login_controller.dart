import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/dashboard_screen.dart';

class LoginController {
  static Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()),
          (route) {
        return false;
      });

      print("Account Login successfully");
    } catch (e) {
      SnackBar messageSnackBAr =
          SnackBar(backgroundColor: Colors.red, content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBAr);
      print(e);
    }
  }
}
