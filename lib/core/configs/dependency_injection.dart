import 'package:clean_architecture/features/data/auth/datasource/auth_datasource.dart';
import 'package:clean_architecture/features/data/auth/repositories/auth_repository_impl.dart';
import 'package:clean_architecture/features/data/customer/datasource/customer_datasource.dart';
import 'package:clean_architecture/features/data/customer/repositories/customer_repository_impl.dart';
import 'package:clean_architecture/features/data/message/datasource/message_datasource.dart';
import 'package:clean_architecture/features/data/message/repositories/message_respository_impl.dart';
import 'package:clean_architecture/features/domain/auth/usecases/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/facebooksingin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/googlesignin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/phonesignin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/signout_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/verifyphone_usecase.dart';
import 'package:clean_architecture/features/domain/customer/usecases/createcustomer_usecase.dart';
import 'package:clean_architecture/features/domain/customer/usecases/getcustomerassociateduser.dart';
import 'package:clean_architecture/features/domain/message/usecases/getmessages_usecase.dart';
import 'package:clean_architecture/features/domain/message/usecases/registermessage_usecase.dart';
import 'package:clean_architecture/features/domain/message/usecases/sendmessage_usecase.dart';
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