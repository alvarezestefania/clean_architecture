import 'package:clean_architecture/features/data/datasource/auth_datasource.dart';
import 'package:clean_architecture/features/domain/gateways/auth_gateway.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthGateway {
  final AuthDatasourceService authDatasourceService;

  AuthRepositoryImpl(this.authDatasourceService);

  @override
  Stream<AuthState> listenToAuthStatus() {
    return authDatasourceService.listenToAuthStatus();
  }
  
  @override
  Future<AuthResponse> signInWithEmailAndPassword(String email, String password) async{
    return await authDatasourceService.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() async{
    return await authDatasourceService.signOut();
  }


}