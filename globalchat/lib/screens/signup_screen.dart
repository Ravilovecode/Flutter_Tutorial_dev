import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/controllers/login_controller.dart';
import 'package:globalchat/controllers/signup_controller%20copy.dart';
import 'package:globalchat/screens/dashboard_screen.dart';
import 'package:globalchat/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var userForm = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: userForm,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/fonts/images/logo.png",
                        width: 150,
                        height: 150,
                      ),
                      TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Email"),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(hintText: "Password"),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Name"),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: country,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Country is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Country"),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          shape: const StadiumBorder(),
                          minimumSize: const Size.fromHeight(50),
                          side:
                              const BorderSide(color: Colors.deepPurpleAccent),
                          elevation: 5,
                          shadowColor: Colors.deepPurpleAccent,
                          textStyle: const TextStyle(fontSize: 20),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (userForm.currentState!.validate()) {
                            SignupController.createAccount(
                                email: email.text,
                                password: password.text,
                                name: name.text,
                                country: country.text,
                                context: context);
                          }
                        },
                        child: const Text("Create account"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
