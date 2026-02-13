import 'package:flutter/material.dart';
import 'package:supabase_template/src/core/theme/app_theme.dart';
import 'package:supabase_template/src/features/auth/presentation/screens/auth_gate.dart';

/// Root widget for the template app.
///
/// Keeps Material configuration centralized and makes it easy to scale
/// navigation/theming without touching `main.dart`.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Template',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const AuthGate(),
    );
  }
}
