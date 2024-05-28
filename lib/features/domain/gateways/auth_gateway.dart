import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthGateway {
  Stream<AuthState> listenToAuthStatus();
  Future<AuthResponse> signInWithEmailAndPassword(String email,String password);
  Future<void> signOut();
}