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

  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResponse credentials = await client.auth
          .signInWithPassword(password: password, email: email);
      return credentials;
    } on AuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    return await client.auth.signOut();
  }

}
