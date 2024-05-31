import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/gateways/auth_gateway.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailsigninUsecase{
  final AuthGateway _authGateway;
  EmailsigninUsecase(this._authGateway);

  Future<User?> call(String email, String password) async {
    try {
      final authResponse = await _authGateway.signInWithEmailAndPassword(email, password);
      return authResponse.user;
    } catch (e) {
       throw CustomException('$e');
    }
  }
}