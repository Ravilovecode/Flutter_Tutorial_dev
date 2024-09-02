import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var userForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(hintText: "Email"),
              ),
              SizedBox(height: 25),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Create account"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
