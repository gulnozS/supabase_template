import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_template/src/core/constants/supabase_tables.dart';
import 'package:supabase_template/src/core/error/app_exception.dart';
import 'package:supabase_template/src/features/reminders/data/models/reminder_model.dart';

class ReminderRemoteDataSource {
  const ReminderRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<ReminderModel>> fetchReminders() async {
    try {
      final response = await _client
          .from(SupabaseTables.reminders)
          .select()
          .order('due_at', ascending: true);

      return response.map((row) => ReminderModel.fromJson(row)).toList();
    } on PostgrestException catch (error) {
      throw AppException(error.message);
    } catch (_) {
      throw const AppException('Unexpected error while fetching reminders.');
    }
  }
}
