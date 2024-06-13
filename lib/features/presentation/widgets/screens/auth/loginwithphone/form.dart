import 'dart:io';
import 'package:clean_architecture/core/configs/routes/router.dart';
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_cubit.dart';
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_state.dart';
import 'package:clean_architecture/features/presentation/widgets/custom_signin_button.dart';
import 'package:clean_architecture/features/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneFormScreen extends StatefulWidget {
  const PhoneFormScreen({super.key});

  @override
  State<PhoneFormScreen> createState() => _PhoneFormScreenState();
}

class _PhoneFormScreenState extends State<PhoneFormScreen> {
  late String _phoneNumber;
  PhoneNumber number = PhoneNumber(
      countryCode: Platform.localeName.split('_').last,
      countryISOCode: Platform.localeName.split('_').last,
      number: Platform.localeName.split('_').last);

  void sendOtp() async {
    await context.read<AuthCubit>().signInWithPhone(_phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AppAuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            LoadingOverlay.showLoadingOverlay(context);
          } else {
            LoadingOverlay.hideLoadingOverlay();
          }

          if (state is AuthFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Error inesperado'),
                ),
              );
            });
          }

          if (state is AuthPhoneVerify) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('OTP enviado. Verifique su número.'),
              ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              // ignore: use_build_context_synchronously
              context.read<RouterSimpleCubit>().goVerifyOtp(_phoneNumber); 
            });
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Icon(Icons.message, size: 80, color: Colors.blue),
                    const SizedBox(
                      height: 50,
                    ),
                    IntlPhoneField(
                      languageCode: 'es',
                      initialCountryCode: 'CO',
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.deepPurpleAccent)),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          filled: true,
                          fillColor: Colors.grey[300]),
                      onChanged: (phone) {
                        _phoneNumber = phone.completeNumber;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Password text

                    //Simple SignIn button
                    CustomSignInButton(
                        text: 'Send OTP', onTap: () => {sendOtp()}),
                    const SizedBox(
                      height: 20,
                    ),
                    //Not a member

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {},
                          child: const Text("Not a member?"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
