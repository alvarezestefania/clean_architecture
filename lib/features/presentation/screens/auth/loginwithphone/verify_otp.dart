import 'package:clean_architecture/core/configs/routes/router.dart';
import 'package:clean_architecture/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:clean_architecture/features/presentation/bloc/auth/auth_state.dart';
import 'package:clean_architecture/features/presentation/widgets/custom_signin_button.dart';
import 'package:clean_architecture/features/presentation/widgets/custom_text_field.dart';
import 'package:clean_architecture/features/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber; 
  const VerifyOtpScreen({super.key, required this.phoneNumber});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void verifyOtp(String phoneNumber,String otp) async {
    await context.read<AuthCubit>().verifyUserPhone(phoneNumber, otp);
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

          if (state is AuthSuccess) {
            context.read<RouterSimpleCubit>().goAuthGate(); 
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Icon(Icons.message, size: 80, color: Colors.blue),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomTextField(
                        controller: codeController,
                        hintText: 'CODE',
                        obscureText: false),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomSignInButton(
                        text: 'Verificar',
                        onTap: () =>
                            {verifyOtp(widget.phoneNumber,codeController.text)}),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
