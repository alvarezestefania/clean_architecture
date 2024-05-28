import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDatasourceService {

  final SupabaseClient client;
  AuthDatasourceService(this.client);

  Stream<AuthState> listenToAuthStatus() {  
    try {
      return client.auth.onAuthStateChange;
    } on AuthException catch (e) {
      throw Exception(e.toString());
    }
  }

}