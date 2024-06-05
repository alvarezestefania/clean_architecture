import 'package:clean_architecture/features/domain/auth/entities/authdata_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthGateway {
  Stream<AuthDataEntity> listenToAuthStatus();
  Future<AuthResponse> signInWithEmailAndPassword(String email,String password);
  Future<void> signInWithFacebook();
  Future<void> signInWithGoogle();
  Future<void> signInWithPhone(String phoneNumber);
  Future<void> verifyUserPhone(String phoneNumber,String otp);
  Future<void> signOut();
}