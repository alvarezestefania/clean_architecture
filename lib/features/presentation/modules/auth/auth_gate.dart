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
    final authProvider = Provider.of<AuthProvider>(context);
    final authState = authProvider.authState;

    // Manejo de estado de carga inicial
    if (authState == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Verificar si el usuario está autenticado
    if (authState.session != null) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
