import 'package:supabase_template/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:supabase_template/src/features/auth/domain/entities/auth_user.dart';
import 'package:supabase_template/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<void> signUp({required String email, required String password}) {
    return _remoteDataSource.signUp(email: email, password: password);
  }

  @override
  Future<void> signIn({required String email, required String password}) {
    return _remoteDataSource.signIn(email: email, password: password);
  }

  @override
  Future<void> signOut() => _remoteDataSource.signOut();

  @override
  Future<AuthUser?> restoreSession() async {
    final user = _remoteDataSource.currentUser();
    if (user == null) return null;
    return AuthUser(id: user.id, email: user.email ?? '');
  }

  @override
  Stream<AuthUser?> authStateChanges() {
    return _remoteDataSource.authStateChanges().map((event) {
      final user = event.session?.user;
      if (user == null) return null;
      return AuthUser(id: user.id, email: user.email ?? '');
    });
  }
}
