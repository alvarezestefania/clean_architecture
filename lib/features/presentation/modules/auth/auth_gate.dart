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
          // Muestra un indicador de carga mientras se obtiene el estado de autenticación
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // Verificar si el usuario está autenticado
        if (authState.session != null) {
          // Si está autenticado, redirigir a la página de inicio
          return const HomePage();
        } else {
          // Si no está autenticado, redirigir a la página de inicio de sesión
          return const LoginPage();
        }
      },
    );
  }
}