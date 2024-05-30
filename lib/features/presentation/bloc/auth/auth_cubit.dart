
import 'package:clean_architecture/features/domain/usecases/auth/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/signout_usecase.dart';
import 'package:clean_architecture/features/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AppAuthState> {
  final ListenToAuthStatusUseCase _listenToAuthStatusUseCase;
  final EmailsigninUsecase _emailsigninUsecase;
  final SignOutUsecase _signOutUsecase;

  AuthCubit(
    this._listenToAuthStatusUseCase,
    this._emailsigninUsecase,
    this._signOutUsecase,
  ) : super(const AuthInitial()) {
    _listenToAuthStatus();
  }

  void _listenToAuthStatus() {
    _listenToAuthStatusUseCase().listen(
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
      _listenToAuthStatus(); 
    } catch (e) {
      emit(AuthFailure(e.toString()));
      // emit(AuthFailure(e.toString()));
    }
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