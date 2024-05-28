import 'package:clean_architecture/features/data/datasource/auth_datasource.dart';
import 'package:clean_architecture/features/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecture/features/domain/usecases/auth/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/signout_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  final client = Supabase.instance.client;

  getIt.registerSingleton<AuthDatasourceService>(AuthDatasourceService(client));
  getIt.registerSingleton<AuthRepositoryImpl>(
      AuthRepositoryImpl(getIt<AuthDatasourceService>()));
  getIt.registerSingleton<ListenToAuthStatusUseCase>(
      ListenToAuthStatusUseCase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<EmailsigninUsecase>(
      EmailsigninUsecase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<SignOutUsecase>(
      SignOutUsecase(getIt<AuthRepositoryImpl>()));
}