import 'package:clean_architecture/features/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthProvider _authProvider; // Definir authProvider aquí

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  void signOut(BuildContext context){
    _authProvider.signOut();
    context.go('/');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(icon: const Icon(Icons.logout),onPressed: () {
          signOut(context);
        },)
      ],),
      body: const Column(
        children: [Text("HI AGAIN")],
      ),
    );
  }
}
