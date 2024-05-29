import 'package:clean_architecture/features/domain/entities/authdata_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthGateway {
  Stream<AuthDataEntity> listenToAuthStatus();
  Future<AuthResponse> signInWithEmailAndPassword(String email,String password);
  Future<void> signOut();
}