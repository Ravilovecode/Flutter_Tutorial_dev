import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/controllers/login_controller.dart';
import 'package:globalchat/screens/dashboard_screen.dart';
import 'package:globalchat/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:globalchat/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userForm = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: userForm,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
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
                ),
                onPressed: () async {
                  if (userForm.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    await LoginController.login(
                        email: email.text,
                        password: password.text,
                        context: context);
                    isLoading = false;
                    setState(() {});
                  }
                },
                child: isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
