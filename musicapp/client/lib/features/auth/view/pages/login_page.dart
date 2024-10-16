import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/theme/utils.dart';
import 'package:client/core/theme/widgets/loader.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailCOntroller = TextEditingController();
  final passwordCOntroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
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
                        'Sign In',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
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
                        text: 'Sign In',
                        onTap: () async {
                          final res = await AuthRemoteRepository().login(
                            email: emailCOntroller.text,
                            password: passwordCOntroller.text,
                          );
                          final val = switch (res) {
                            Left(value: final l) => l,
                            Right(value: final r) => r,
                          };
                          print(val);
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignupPage();
                          }));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account?   ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                  text: 'Sign Up',
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
