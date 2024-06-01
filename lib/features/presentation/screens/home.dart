import 'package:clean_architecture/core/configs/routes/router.dart';
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_cubit.dart';
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void signOut(BuildContext context) {
    context.read<AuthCubit>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AppAuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          final authData = state.authData;
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () {
                    context.read<RouterSimpleCubit>().goChatPage(); 
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Text(
                    "HI AGAIN ${authData.accessToken != '' ? "logg" : "not logged"}"),
                Text("email ${authData.user?.email ?? ""}"),
              ],
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
