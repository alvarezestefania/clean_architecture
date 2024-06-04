import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/data/models/user_model.dart';
import 'package:clean_architecture/features/domain/entities/authdata_entity.dart';
import 'package:flutter/foundation.dart';
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
              user: UserModel.fromJson(session.user.toJson()).toEntity(),
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
      throw CustomException('Error inesperado: ${e.toString()} ${e.hashCode}');
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

  Future<void> signInWithFacebook() async {
    try {
      await client.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo:
            kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
    } catch (e) {
      throw CustomException('Error inesperado: ${e.toString()}');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo:
            kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
    } catch (e) {
      throw CustomException('Error inesperado: ${e.toString()}');
    }
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    try {
      await client.auth
          .signInWithOtp(phone: phoneNumber, shouldCreateUser: true);
    } catch (e) {
      throw CustomException('Error inesperado: ${e.toString()}');
    }
  }

  Future<AuthResponse> verifyUserPhone(String phoneNumber, String otp) async {
    try {
      AuthResponse response = await client.auth.verifyOTP(
        token: otp,
        type: OtpType.sms,
        phone: phoneNumber,
      );
      return response;
    } on Exception catch (e) {
      throw CustomException('Error inesperado: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    return await client.auth.signOut();
  }
}
