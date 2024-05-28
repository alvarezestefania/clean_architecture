import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthGateway {
  Stream<AuthState> listenToAuthStatus();
}