import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Reads runtime environment variables from `.env`.
///
/// Keeping keys in one place avoids scattered string literals and makes
/// environment changes safer in larger projects.
final class EnvConfig {
  const EnvConfig._();

  static Future<void> load() => dotenv.load(fileName: '.env');

  static String get supabaseUrl => _required('SUPABASE_URL');

  static String get supabaseAnonKey => _required('SUPABASE_ANON_KEY');

  static String _required(String key) {
    final value = dotenv.env[key];
    if (value == null || value.trim().isEmpty) {
      throw StateError('Missing required env variable: $key');
    }
    return value;
  }
}
