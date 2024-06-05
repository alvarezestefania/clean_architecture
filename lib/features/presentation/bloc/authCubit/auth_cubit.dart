import 'package:clean_architecture/features/domain/auth/usecases/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/facebooksingin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/googlesignin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/phonesignin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/signout_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/verifyphone_usecase.dart';
import 'package:clean_architecture/features/presentation/bloc/authCubit/auth_state.dart';
import 'package:clean_architecture/features/presentation/bloc/customer/customer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AppAuthState> {
  final ListenToAuthStatusUseCase _listenToAuthStatusUseCase;
  final EmailsigninUsecase _emailsigninUsecase;
  final FacebookSignInUsecase _facebookSingInUsecase;
  final GoogleSignInUsecase _googleSingInUsecase;
  final PhoneSignInUsecase _phoneSignInUsecase;
  final VerifyPhoneSignInUsecase _verifyPhoneSignInUsecase;
  final SignOutUsecase _signOutUsecase;
  final CustomerCubit _customerCubit;

  AuthCubit(
      this._listenToAuthStatusUseCase,
      this._emailsigninUsecase,
      this._facebookSingInUsecase,
      this._googleSingInUsecase,
      this._phoneSignInUsecase,
      this._verifyPhoneSignInUsecase,
      this._signOutUsecase,
      this._customerCubit)
      : super(const AuthInitial()) {
    _listenToAuthStatus();
  }

  void _listenToAuthStatus() {
    _listenToAuthStatusUseCase().listen(
      (authData) async {
        if (authData.user != null && authData.accessToken.isNotEmpty) {
          await _customerCubit.loadCustomer(
              authData.user!.id, authData.user!.email!);
        }
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
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(AuthLoading());
    try {
      await _facebookSingInUsecase();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      await _googleSingInUsecase();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    emit(AuthLoading());
    try {
      await _phoneSignInUsecase(phoneNumber);
      emit(AuthPhoneVerify());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> verifyUserPhone(String phoneNumber, String otp) async {
    emit(AuthLoading());
    try {
      await _verifyPhoneSignInUsecase(phoneNumber, otp);
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Future<void> registerCustomerIfDoesNotExist()async{
  //   _listenToAuthStatus();
  //   _listenToAuthStatusUseCase().listen(
  //     (authData) {
  //       if (authData.user != null) {
  //         _createCustomerifNotExistUseCase(
  //             authData.user!.id,
  //             CustomerEntity(
  //                 id: null,
  //                 name: authData.user?.email ?? "",
  //                 userId: authData.user!.id));
  //       }
  //     },onError: (e) {
  //       emit(AuthFailure(e.toString()));
  //     },
  //   );
  // }

  Future<void> signOut() async {
    try {
      await _signOutUsecase();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
