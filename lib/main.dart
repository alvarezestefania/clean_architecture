import 'package:clean_architecture/app/app.dart';
import 'package:clean_architecture/core/configs/dependency_injection.dart';
import 'package:clean_architecture/core/configs/routes/router.dart';
import 'package:clean_architecture/features/domain/auth/usecases/facebooksingin_usecase.dart';
import 'package:clean_architecture/features/domain/customer/usecases/getcustomerassociateduser.dart';
import 'package:clean_architecture/features/domain/auth/usecases/googlesignin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/phonesignin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/signout_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/verifyphone_usecase.dart';
import 'package:clean_architecture/features/domain/customer/usecases/createcustomer_usecase.dart';
import 'package:clean_architecture/features/domain/message/usecases/getmessages_usecase.dart';
import 'package:clean_architecture/features/domain/message/usecases/registermessage_usecase.dart';
import 'package:clean_architecture/features/domain/message/usecases/sendmessage_usecase.dart';
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
