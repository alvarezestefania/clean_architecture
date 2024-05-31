import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/data/datasource/auth_datasource.dart';
import 'package:clean_architecture/features/domain/entities/authdata_entity.dart';
import 'package:clean_architecture/features/domain/gateways/auth_gateway.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthGateway {
  final AuthDatasourceService authDatasourceService;

  AuthRepositoryImpl(this.authDatasourceService);

  @override
  Stream<AuthDataEntity> listenToAuthStatus() {
    try {
      return authDatasourceService.listenToAuthStatus();
    } catch (e) {
      throw CustomException('Failed to listen to auth status');
    }
  }
  
  @override
  Future<AuthResponse> signInWithEmailAndPassword(String email, String password) async{
    try{
      return await authDatasourceService.signInWithEmailAndPassword(email, password);
    }catch (e) {
      throw CustomException(e.toString());
    } 
  }

  @override
  Future<void> signInWithFacebook() async{
    try{
      await authDatasourceService.signInWithFacebook();
    }catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<void> signInWithGoogle() async{
    try{
      await authDatasourceService.signInWithGoogle();
    }catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<void> signInWithPhone(String phoneNumber) async{
    try{
      await authDatasourceService.signInWithPhoneNumber(phoneNumber);
    }catch (e) {
      throw CustomException(e.toString());
    }
  }

    @override
  Future<void> verifyUserPhone(String phoneNumber,String otp) async{
    try{
      await authDatasourceService.verifyUserPhone(phoneNumber, otp);
    }catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<void> signOut() async{
    return await authDatasourceService.signOut();
  }

}