import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_template/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:supabase_template/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:supabase_template/src/features/reminders/presentation/screens/reminders_screen.dart';

/// Entry point that decides whether to show auth or the app feature.
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restoreState = ref.watch(sessionRestoreProvider);
    return restoreState.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(
        body: Center(child: Text('Failed to restore session: $error')),
      ),
      data: (_) {
        final authState = ref.watch(authStateProvider);
        return authState.when(
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (error, _) =>
              Scaffold(body: Center(child: Text('Auth stream error: $error'))),
          data: (user) =>
              user == null ? const SignInScreen() : const RemindersScreen(),
        );
      },
    );
  }
}
