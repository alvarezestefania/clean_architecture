import 'package:clean_architecture/features/domain/auth/entities/authdata_entity.dart';
import 'package:clean_architecture/features/domain/auth/usecases/emailsignin_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/listeauthstatus_usecase.dart';
import 'package:clean_architecture/features/domain/auth/usecases/signout_usecase.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final ListenToAuthStatusUseCase _listenToAuthStatusUseCase;
  final EmailsigninUsecase _emailsigninUsecase;
  final SignOutUsecase _signOutUsecase;

  AuthDataEntity? _authState;

  AuthProvider(this._listenToAuthStatusUseCase, this._emailsigninUsecase,
      this._signOutUsecase) {
    _listenToAuthStatus();
  }

  AuthDataEntity? get authState => _authState;

  bool _hasError = false;
  String _errorMessage = '';

  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  void _setError(String message) {
    _hasError = true;
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _hasError = false;
    _errorMessage = '';
    notifyListeners();
  }

  void _listenToAuthStatus() {
    _listenToAuthStatusUseCase().listen((authState) {
      _authState = authState;
      notifyListeners();
    },onError: (e) {
      _setError(e.toString());
      notifyListeners();
    });
  }

  Future<void> signInWithEmail(String email, String password) async {
    clearError();
    await _emailsigninUsecase(email, password);
  }

  Future<void> signOut() async {
    clearError();
    return await _signOutUsecase();
  }
}
