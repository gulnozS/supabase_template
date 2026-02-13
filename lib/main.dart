import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_template/src/app/app.dart';
import 'package:supabase_template/src/core/config/env_config.dart';
import 'package:supabase_template/src/core/config/supabase_initializer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.load();
  await initializeSupabase();
  runApp(const ProviderScope(child: App()));
}
