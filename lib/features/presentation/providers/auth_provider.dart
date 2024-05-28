import 'package:clean_architecture/features/domain/usecases/auth/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/auth/signout_usecase.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final ListenToAuthStatusUseCase _listenToAuthStatusUseCase;
  final EmailsigninUsecase _emailsigninUsecase;
  final SignOutUsecase _signOutUsecase;

  AuthState? _authState;

  AuthProvider(this._listenToAuthStatusUseCase, this._emailsigninUsecase,
      this._signOutUsecase) {
    _listenToAuthStatus();
  }

  AuthState? get authState => _authState;

  void _listenToAuthStatus() {
    _listenToAuthStatusUseCase().listen((authState) {
      _authState = authState;
      notifyListeners();
    });
  }

  Future<void> signInWithEmail(String email, String password) async {
    await _emailsigninUsecase(email, password);
  }

  Future<void> signOut() async {
    return await _signOutUsecase();
  }
}
