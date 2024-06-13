import 'dart:async';
import 'package:clean_architecture/core/configs/routes/router.dart';
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_cubit.dart';
import 'package:clean_architecture/features/presentation/widgets/custom_signin_button.dart';
import 'package:clean_architecture/features/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum SignInOptions { email, google, facebook, number }

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn(SignInOptions option) async {
    if (!mounted) {
      return;
    }
    String email = emailController.text;
    String password = passwordController.text;

    switch (option) {
      case SignInOptions.email:
        await context.read<AuthCubit>().signInWithEmail(email, password);
        break;
      case SignInOptions.google:
      await context.read<AuthCubit>().signInWithGoogle();
        break;
      case SignInOptions.facebook:
        await context.read<AuthCubit>().signInWithFacebook();
        break;
      case SignInOptions.number:
        context.read<RouterSimpleCubit>().goPhoneForm(); 
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Icon(Icons.message, size: 80, color: Colors.blue),
                const SizedBox(
                  height: 50,
                ),
                // Email text
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                // Password text
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                // Simple SignIn button
                CustomSignInButton(
                  text: 'Sign In',
                  onTap: () => signIn(SignInOptions.email),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    // SignIn with Facebook or Google account
                    SignInButton(
                      elevation: 3,
                      Buttons.google,
                      text: "sign with Google",
                      onPressed: () => signIn(SignInOptions.google),
                    ),
                    SignInButton(
                      elevation: 10.0,
                      Buttons.facebook,
                      text: "sign with Facebook",
                      onPressed: () => signIn(SignInOptions.facebook),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () => signIn(SignInOptions.number),
                      child: Container(
                        width: 220,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 12,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Row(
                            children: [
                              Icon(Icons.phone, size: 20, color: Colors.blue),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'sign with number',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                // Not a member
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?"),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
