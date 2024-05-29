// ignore_for_file: use_build_context_synchronously
import 'package:clean_architecture/features/presentation/providers/auth_provider.dart';
import 'package:clean_architecture/features/presentation/widgets/custom_signin_button.dart';
import 'package:clean_architecture/features/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum SignInOptions { email, google, facebook, number }

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  Future<void> signIn(SignInOptions option) async {
    if (!mounted) {
      return;
    }

    try {
      String email = emailController.text;
      String password = passwordController.text;
      await _authProvider.signInWithEmail(email, password);

      if (mounted) {
        context.push('/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error inesperado. Intena nuevamente'),
        ),
      );
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
                //Email text
                CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(
                  height: 15,
                ),
                //Password text
                CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(
                  height: 15,
                ),
                //Simple SignIn button
                CustomSignInButton(
                    text: 'Sign In', onTap: () => signIn(SignInOptions.email)),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    //SignIn with Facebook or Google account
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
                            vertical: 5, horizontal: 12),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Color de la sombra
                              spreadRadius: 0, // Difuminado de la sombra
                              blurRadius: 5, // Desenfoque de la sombra
                              offset: Offset(0,
                                  3), // Desplazamiento de la sombra (horizontal, vertical)
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
                                    fontSize: 13),
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
                //Not a member
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?"),
                    SizedBox(
                      width: 5,
                    ),
                    // GestureDetector(
                    //     onTap: widget.onTap, child: const Text("Register now"))
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
