import 'package:clean_architecture/core/configs/routes/router.dart';
import 'package:clean_architecture/features/presentation/modules/auth/auth_gate.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
    // return MaterialApp.router(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
      
    //   routeInformationParser: AppRouter().router.routeInformationParser,
    //   routerDelegate: AppRouter().router.routerDelegate,
    //   routeInformationProvider: AppRouter().router.routeInformationProvider,
    //   debugShowCheckedModeBanner: false,
    // );
  }
}
