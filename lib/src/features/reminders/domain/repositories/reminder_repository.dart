import 'package:supabase_template/src/features/reminders/domain/entities/reminder.dart';

abstract interface class ReminderRepository {
  Future<List<Reminder>> fetchReminders();
}
