import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/data/models/user_model.dart';
import 'package:clean_architecture/features/domain/entities/authdata_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDatasourceService {
  final SupabaseClient client;
  AuthDatasourceService(this.client);

  Stream<AuthDataEntity> listenToAuthStatus() {
    try {
      final Stream<AuthDataEntity> response =
          client.auth.onAuthStateChange.map((data) {
        final Session? session = data.session;
        if (session != null) {
          return AuthDataEntity(
            accessToken: session.accessToken,
            refreshToken: session.refreshToken ?? '',
            user: UserModel.fromJson(session.user.toJson()).toEntity()
          );
        } else {
          return AuthDataEntity(
            accessToken: '',
            refreshToken: '',
            user: null,
          );
        }
      });

      return response;
    } catch (e) {
      throw CustomException('Error inesperado: ${e.toString()}');
    }
    
  }

  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResponse credentials = await client.auth
          .signInWithPassword(password: password, email: email);
      return credentials;
    } catch (e) {
      throw CustomException('Error inesperado: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    return await client.auth.signOut();
  }
}
