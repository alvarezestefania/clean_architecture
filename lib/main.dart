import 'package:clean_architecture/app/app.dart';
import 'package:clean_architecture/core/configs/dependency_injection.dart';
import 'package:clean_architecture/core/configs/routes/router.dart';
import 'package:clean_architecture/features/domain/usecases/auth/facebooksingin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/customer/getcustomerassociateduser.dart';
import 'package:clean_architecture/features/domain/usecases/auth/googlesignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/phonesignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/signout_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/verifyphone_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/customer/createcustomer_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/messages/getmessages_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/messages/registermessage_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/messages/sendMessage_usecase.dart';
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_cubit.dart';
import 'package:clean_architecture/features/presentation/bloc/chatCubit/chat_cubit.dart';
import 'package:clean_architecture/features/presentation/bloc/customer/customer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  await Supabase.initialize(
      authOptions: const FlutterAuthClientOptions(autoRefreshToken: true),
      url: supabaseUrl,
      anonKey: supabaseKey);

  String geminiApiKey = dotenv.env['GEMINI_KEY'] ?? '';
  Gemini.init(
    apiKey: geminiApiKey,
  );
  setupDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => CustomerCubit(
          getIt<GetCustomerByUserIdUseCase>(),
          getIt<CreateCustomerIfNotExistUsecase>(),
        ),
      ),
      BlocProvider(
        create: (context) => AuthCubit(
          getIt<ListenToAuthStatusUseCase>(),
          getIt<EmailsigninUsecase>(),
          getIt<FacebookSignInUsecase>(),
          getIt<GoogleSignInUsecase>(),
          getIt<PhoneSignInUsecase>(),
          getIt<VerifyPhoneSignInUsecase>(),
          getIt<SignOutUsecase>(),
          context.read<CustomerCubit>(),
        ),
      ),
      BlocProvider(
        create: (context) => ChatCubit(
          getIt<GetChatMessagesUsecase>(),
          getIt<RegisterMessageUsecase>(),
          getIt<SendMessageToAiUsecase>(),
        ),
      ),
      BlocProvider(create: (context) => RouterSimpleCubit(), lazy: false)
    ],
    child: const MyApp(),
  ));
}
