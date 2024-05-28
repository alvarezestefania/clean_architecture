import 'package:clean_architecture/features/domain/usecases/auth/listeauthstatus_usecase.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final ListenToAuthStatusUseCase _listenToAuthStatusUseCase;
  AuthState? _authState;

  AuthProvider(this._listenToAuthStatusUseCase) {
    _listenToAuthStatus();
  }

  AuthState? get authState => _authState;

  void _listenToAuthStatus() {
    _listenToAuthStatusUseCase().listen((authState) {
      _authState = authState;
      notifyListeners();
    });
  }
}