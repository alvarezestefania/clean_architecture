import 'package:clean_architecture/app/app.dart';
import 'package:clean_architecture/core/configs/dependency_injection.dart';
import 'package:clean_architecture/features/domain/usecases/auth/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/signout_usecase.dart';
import 'package:clean_architecture/features/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
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
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(
        getIt<ListenToAuthStatusUseCase>(),
        getIt<EmailsigninUsecase>(),
        getIt<SignOutUsecase>(),
      ),
      child: const MyApp(),
    ),
  );
}
