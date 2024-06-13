// ignore_for_file: unrelated_type_equality_checks
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_cubit.dart';
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_state.dart';
import 'package:clean_architecture/features/presentation/widgets/screens/auth/login_screen.dart';
import 'package:clean_architecture/features/presentation/widgets/screens/home.dart';
import 'package:clean_architecture/features/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
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
      },
      child: BlocBuilder<AuthCubit, AppAuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            if (state.authData.accessToken.isNotEmpty) {
              return const HomePage();
            } else {
              return const LoginScreen();
            }
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
