import 'package:clean_architecture/features/data/datasource/auth_datasource.dart';
import 'package:clean_architecture/features/data/datasource/customer_datasource.dart';
import 'package:clean_architecture/features/data/datasource/message_datasource.dart';
import 'package:clean_architecture/features/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecture/features/data/repositories/customer_repository_impl.dart';
import 'package:clean_architecture/features/data/repositories/message_respository_impl.dart';
import 'package:clean_architecture/features/domain/usecases/auth/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/facebooksingin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/customer/getcustomerassociateduser.dart';
import 'package:clean_architecture/features/domain/usecases/auth/googlesignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/phonesignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/signout_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/verifyphone_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/customer/createcustomer_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/messages/getmessages_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/messages/registermessage_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/messages/sendMessage_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  final client = Supabase.instance.client;

  //CUSTOMER INJECTION DEPENDENCIES
  getIt.registerSingleton<CustomerDataSourceService>(CustomerDataSourceService(client));
  getIt.registerSingleton<CustomerRepositoryImpl>(
      CustomerRepositoryImpl(getIt<CustomerDataSourceService>()));
  getIt.registerSingleton<GetCustomerByUserIdUseCase>(
      GetCustomerByUserIdUseCase(getIt<CustomerRepositoryImpl>(),));
  getIt.registerSingleton<CreateCustomerIfNotExistUsecase>(
      CreateCustomerIfNotExistUsecase(getIt<CustomerRepositoryImpl>()));

  //OAUTH INJECTION DEPENDENCIES
  getIt.registerSingleton<AuthDatasourceService>(AuthDatasourceService(client));
  getIt.registerSingleton<AuthRepositoryImpl>(
      AuthRepositoryImpl(getIt<AuthDatasourceService>()));
  getIt.registerSingleton<ListenToAuthStatusUseCase>(
      ListenToAuthStatusUseCase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<EmailsigninUsecase>(
      EmailsigninUsecase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<FacebookSignInUsecase>(
      FacebookSignInUsecase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<GoogleSignInUsecase>(
      GoogleSignInUsecase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<PhoneSignInUsecase>(
      PhoneSignInUsecase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<VerifyPhoneSignInUsecase>(
      VerifyPhoneSignInUsecase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<SignOutUsecase>(
      SignOutUsecase(getIt<AuthRepositoryImpl>()));

  

  //MESSAGE INJECTION DEPENDENCIES
  getIt.registerSingleton<MessageDatasourceService>(MessageDatasourceService(client));
  getIt.registerSingleton<MessageRespositoryImpl>(
      MessageRespositoryImpl(getIt<MessageDatasourceService>()));
  getIt.registerSingleton<GetChatMessagesUsecase>(
      GetChatMessagesUsecase(getIt<MessageRespositoryImpl>()));
  getIt.registerSingleton<RegisterMessageUsecase>(
      RegisterMessageUsecase(getIt<MessageRespositoryImpl>()));
  getIt.registerSingleton<SendMessageToAiUsecase>(
      SendMessageToAiUsecase(getIt<MessageRespositoryImpl>()));
      
}