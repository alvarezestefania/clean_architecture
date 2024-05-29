import 'package:clean_architecture/features/presentation/modules/auth/login.dart';
import 'package:clean_architecture/features/presentation/modules/home.dart';
import 'package:clean_architecture/features/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final authState = authProvider.authState;
        if (authState == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if(authProvider.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(authProvider.errorMessage),
                duration: const Duration(seconds: 3), // Duración del SnackBar
                action: SnackBarAction(
                  label: 'Cerrar',
                  onPressed: () {
                    authProvider.clearError(); // Limpiar el mensaje de error
                  },
                ),
              ),
            );
          });
        }

        if (authState.accessToken != '') {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}