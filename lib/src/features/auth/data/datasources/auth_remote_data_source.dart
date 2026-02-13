import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_template/src/core/error/app_exception.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _client.auth.signUp(email: email, password: password);
    } on AuthException catch (error) {
      throw AppException(error.message);
    } catch (_) {
      throw const AppException('Unexpected error while signing up.');
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (error) {
      throw AppException(error.message);
    } catch (_) {
      throw const AppException('Unexpected error while signing in.');
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on AuthException catch (error) {
      throw AppException(error.message);
    } catch (_) {
      throw const AppException('Unexpected error while signing out.');
    }
  }

  User? currentUser() => _client.auth.currentUser;

  Stream<AuthState> authStateChanges() => _client.auth.onAuthStateChange;
}
