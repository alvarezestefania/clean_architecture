import 'package:clean_architecture/features/domain/auth/entities/authdata_entity.dart';

abstract class AppAuthState {
  const AppAuthState();
}
class AuthInitial extends AppAuthState {
  const AuthInitial();
}

class AuthLoading extends AppAuthState {}

class AuthPhoneVerify extends AppAuthState{}

class AuthSuccess extends AppAuthState {
  final AuthDataEntity authData;
  AuthSuccess(this.authData);
}

class AuthFailure extends AppAuthState {
  final String? errorMessage;
  AuthFailure(this.errorMessage);
}