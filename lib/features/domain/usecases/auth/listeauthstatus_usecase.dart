
import 'package:clean_architecture/features/domain/gateways/auth_gateway.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListenToAuthStatusUseCase {
  final AuthGateway repository;
  ListenToAuthStatusUseCase(this.repository);

  Stream<AuthState> call() {
    return repository.listenToAuthStatus();
  }
}