import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show Supabase, SupabaseClient;
import 'package:supabase_template/src/core/error/app_exception.dart';
import 'package:supabase_template/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:supabase_template/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:supabase_template/src/features/auth/domain/entities/auth_user.dart';
import 'package:supabase_template/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_template/src/features/auth/domain/usecases/restore_session_use_case.dart';
import 'package:supabase_template/src/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:supabase_template/src/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:supabase_template/src/features/auth/domain/usecases/sign_up_use_case.dart';

/// DI: base Supabase client provider.
final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => Supabase.instance.client,
);

/// DI: auth data source provider.
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(ref.watch(supabaseClientProvider)),
);

/// DI: auth repository provider.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider)),
);

/// DI: use-cases.
final signInUseCaseProvider = Provider<SignInUseCase>(
  (ref) => SignInUseCase(ref.watch(authRepositoryProvider)),
);
final signUpUseCaseProvider = Provider<SignUpUseCase>(
  (ref) => SignUpUseCase(ref.watch(authRepositoryProvider)),
);
final signOutUseCaseProvider = Provider<SignOutUseCase>(
  (ref) => SignOutUseCase(ref.watch(authRepositoryProvider)),
);
final restoreSessionUseCaseProvider = Provider<RestoreSessionUseCase>(
  (ref) => RestoreSessionUseCase(ref.watch(authRepositoryProvider)),
);

/// Restores a locally persisted session on app startup.
final sessionRestoreProvider = FutureProvider<AuthUser?>(
  (ref) => ref.watch(restoreSessionUseCaseProvider).call(),
);

/// Emits auth state updates from Supabase.
final authStateProvider = StreamProvider<AuthUser?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges(),
);

/// Handles auth actions and exposes loading/error state to the UI.
class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController(this._ref) : super(const AsyncData(null));

  final Ref _ref;

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _ref
          .read(signInUseCaseProvider)
          .call(email: email.trim(), password: password.trim()),
    );
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _ref
          .read(signUpUseCaseProvider)
          .call(email: email.trim(), password: password.trim()),
    );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _ref.read(signOutUseCaseProvider).call(),
    );
  }

  String mapError(Object error) {
    if (error is AppException) return error.message;
    return 'Unexpected error. Please try again.';
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>(AuthController.new);
