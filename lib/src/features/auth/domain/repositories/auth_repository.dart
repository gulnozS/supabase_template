import 'package:supabase_template/src/features/auth/domain/entities/auth_user.dart';

abstract interface class AuthRepository {
  Future<void> signUp({required String email, required String password});

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();

  Future<AuthUser?> restoreSession();

  Stream<AuthUser?> authStateChanges();
}
