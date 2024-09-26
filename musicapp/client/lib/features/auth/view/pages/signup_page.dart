import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              CustomField(
                hintText: 'Name',
              ),
              SizedBox(height: 15),
              CustomField(
                hintText: 'Email',
              ),
              SizedBox(height: 15),
              CustomField(
                hintText: 'Password',
              ),
              SizedBox(height: 20),
              AuthGradientButton(text: 'Sign Up'),
            ],
          ),
        ),
      ),
    );
  }
}
