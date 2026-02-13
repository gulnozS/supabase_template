import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_template/src/core/config/env_config.dart';

/// One place to initialize Supabase for the whole app.
Future<void> initializeSupabase() {
  return Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
  );
}
