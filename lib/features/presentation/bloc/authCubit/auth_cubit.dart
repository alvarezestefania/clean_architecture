import 'package:clean_architecture/features/domain/entities/customer_entity.dart';
import 'package:clean_architecture/features/domain/usecases/auth/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/facebooksingin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/googlesignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/phonesignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/signout_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/verifyphone_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/customer/createcustomer_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/getcustomerassociateduser.dart';
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AppAuthState> {
  final ListenToAuthStatusUseCase _listenToAuthStatusUseCase;
  final GetAuthAndCustomerUseCase _getAuthAndCustomerUseCase;
  final EmailsigninUsecase _emailsigninUsecase;
  final FacebookSignInUsecase _facebookSingInUsecase;
  final GoogleSignInUsecase _googleSingInUsecase;
  final PhoneSignInUsecase _phoneSignInUsecase;
  final VerifyPhoneSignInUsecase _verifyPhoneSignInUsecase;
  final SignOutUsecase _signOutUsecase;
  final CreateCustomerIfNotExistUsecase _createCustomerifNotExistUseCase;


  AuthCubit(
      this._listenToAuthStatusUseCase,
      this._getAuthAndCustomerUseCase,
      this._emailsigninUsecase,
      this._facebookSingInUsecase,
      this._googleSingInUsecase,
      this._phoneSignInUsecase,
      this._verifyPhoneSignInUsecase,
      this._signOutUsecase,
      this._createCustomerifNotExistUseCase, 
      )
      : super(const AuthInitial()) {
    _listenToAuthStatus();
  }


  void _listenToAuthStatus() {
    _getAuthAndCustomerUseCase().then(
      (authData) {
        emit(AuthSuccess(authData));
      },
      onError: (e) {
        emit(AuthFailure(e.toString()));
      },
    );
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(AuthLoading());
    try {
      await _emailsigninUsecase(email, password);
      await registerCustomerIfDoesNotExist();
      _listenToAuthStatus();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(AuthLoading());
    try {
      await _facebookSingInUsecase();
      registerCustomerIfDoesNotExist();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      await _googleSingInUsecase();
      registerCustomerIfDoesNotExist();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    emit(AuthLoading());
    try {
      await _phoneSignInUsecase(phoneNumber);
      await registerCustomerIfDoesNotExist();
      emit(AuthPhoneVerify());   
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> verifyUserPhone(String phoneNumber,String otp) async {
    emit(AuthLoading());
    try {
      await _verifyPhoneSignInUsecase(phoneNumber,otp);
      _listenToAuthStatus();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> registerCustomerIfDoesNotExist()async{
    _listenToAuthStatus();
    _listenToAuthStatusUseCase().listen(
      (authData) {
        if (authData.user != null) {
          print( authData.user!.id);
          _createCustomerifNotExistUseCase(
              authData.user!.id,
              CustomerEntity(
                  id: null,
                  name: authData.user?.email ?? "",
                  userId: authData.user!.id));
        }
      },onError: (e) {
        emit(AuthFailure(e.toString()));
      },
    );
  }

  Future<void> signOut() async {
    try {
      await _signOutUsecase();
      _listenToAuthStatus();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
