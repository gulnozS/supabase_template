import 'package:supabase_template/src/features/auth/domain/entities/auth_user.dart';
import 'package:supabase_template/src/features/auth/domain/repositories/auth_repository.dart';

class RestoreSessionUseCase {
  const RestoreSessionUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser?> call() => _repository.restoreSession();
}
