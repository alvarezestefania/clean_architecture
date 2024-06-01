import 'package:clean_architecture/core/configs/routes/routes.dart';
import 'package:clean_architecture/features/presentation/screens/auth/auth_gate.dart';
import 'package:clean_architecture/features/presentation/screens/auth/login_screen.dart';
import 'package:clean_architecture/features/presentation/screens/auth/loginwithphone/form.dart';
import 'package:clean_architecture/features/presentation/screens/auth/loginwithphone/verify_otp.dart';
import 'package:clean_architecture/features/presentation/screens/chat/chat_screen.dart';
import 'package:clean_architecture/features/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {

  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: AppRoutes.authGate.name,
        builder: (context, state) => const AuthGate(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoutes.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoutes.home.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/phoneFormScreen',
        name: AppRoutes.phoneFormScreen.name,
        builder: (context, state) => const PhoneFormScreen(),
      ),
      GoRoute(
        path: '/verifyOtp',
        name: AppRoutes.verifyOtp.name,
        builder: (context, state) => VerifyOtpScreen(phoneNumber: state.extra as String,),
      ),
      GoRoute(
        path: '/ChatScreen',
        name: AppRoutes.chatPage.name,
        builder: (context, state) => const ChatScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  );
}

class RouterSimpleCubit extends Cubit<GoRouter> {
  RouterSimpleCubit() : super(AppRouter().router);

  void goAuthGate() {
    state.go('/');
  }

  void goPhoneForm() {
    state.push('/phoneFormScreen');
  }

  void goVerifyOtp(String phoneNumber) {
    state.push('/verifyOtp', extra: phoneNumber);
  }

  void goHome() {
    state.push('/Home');
  }

  void goChatPage() {
    state.push('/ChatScreen');
  }
}
