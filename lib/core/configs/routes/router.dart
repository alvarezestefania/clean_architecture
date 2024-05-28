// import 'package:clean_architecture/core/configs/routes/routes.dart';
// import 'package:clean_architecture/features/presentation/modules/auth/auth_gate.dart';
// import 'package:clean_architecture/features/presentation/modules/auth/login.dart';
// import 'package:clean_architecture/features/presentation/modules/home.dart';
// import 'package:clean_architecture/features/presentation/providers/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class AppRouter {
//   final AuthProvider authProvider;

//   AppRouter(this.authProvider);

//   GoRouter get router => GoRouter(
//         initialLocation: '/',
//         routes: [
//           GoRoute(
//             path: '/',
//             name: AppRoute.login.name,
//             builder: (context, state) => const AuthGate(),
//           ),
//           GoRoute(
//             path: '/home',
//             name: AppRoute.home.name,
//             builder: (context, state) => const HomePage(),
//           ),
//         ],
//       );
// }

import 'package:clean_architecture/core/configs/routes/routes.dart';
import 'package:clean_architecture/features/presentation/modules/auth/auth_gate.dart';
import 'package:clean_architecture/features/presentation/modules/auth/login.dart';
import 'package:clean_architecture/features/presentation/modules/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class AppRouter{

  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: AppRoute.authGate.name,
        builder: (context, state) => const AuthGate(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  );
}