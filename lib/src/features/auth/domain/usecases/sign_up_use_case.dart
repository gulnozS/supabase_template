import 'package:supabase_template/src/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call({required String email, required String password}) {
    return _repository.signUp(email: email, password: password);
  }
}
