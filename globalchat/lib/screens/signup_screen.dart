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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Form(
        key: userForm,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 100),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: const StadiumBorder(),
                  minimumSize: const Size.fromHeight(50),
                  side: const BorderSide(color: Colors.deepPurpleAccent),
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
                        context: context);
                  }
                },
                child: const Text("Create account"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
