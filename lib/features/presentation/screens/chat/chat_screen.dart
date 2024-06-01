import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_cubit.dart';
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_state.dart';
import 'package:clean_architecture/features/presentation/widgets/loading.dart';
import 'package:clean_architecture/features/presentation/widgets/message_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  late String _customerId;

  @override
  void initState() {
    super.initState();
    _customerId = _getUserIdFromAuthCubit();
  }

  String _getUserIdFromAuthCubit() {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final AuthSuccess successState = authCubit.state as AuthSuccess;
    return successState.authData.customerId;
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
      },
      child: BlocBuilder<AuthCubit, AppAuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Mensajeria")),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("LOS MENSJEAS"),
                InputMessage(customerId: _customerId,),
              ],
            ),
          );
        },
      ),
    );
  }
}
