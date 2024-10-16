import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/theme/utils.dart';
import 'package:client/core/theme/widgets/loader.dart';

import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameCOntroller = TextEditingController();
  final emailCOntroller = TextEditingController();
  final passwordCOntroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    nameCOntroller.dispose();
    emailCOntroller.dispose();
    passwordCOntroller.dispose();
    super.dispose();
    formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          // TODO: implement data
          showSnackBar(context, 'Account created successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LoginPage();
          }));
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {
          return const Loader();
        },
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      CustomField(
                        hintText: 'Name',
                        controller: nameCOntroller,
                      ),
                      SizedBox(height: 15),
                      CustomField(
                        hintText: 'Email',
                        controller: emailCOntroller,
                      ),
                      SizedBox(height: 15),
                      CustomField(
                        hintText: 'Password',
                        controller: passwordCOntroller,
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      AuthGradientButton(
                        text: 'Sign Up',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await ref
                                .read(authViewModelProvider.notifier)
                                .signup(
                                    name: nameCOntroller.text,
                                    email: emailCOntroller.text,
                                    password: passwordCOntroller.text);
                          }
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?   ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(color: Pallete.gradient2))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
