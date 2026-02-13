import 'package:supabase_template/src/features/reminders/data/datasources/reminder_remote_data_source.dart';
import 'package:supabase_template/src/features/reminders/domain/entities/reminder.dart';
import 'package:supabase_template/src/features/reminders/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  const ReminderRepositoryImpl(this._remoteDataSource);

  final ReminderRemoteDataSource _remoteDataSource;

  @override
  Future<List<Reminder>> fetchReminders() => _remoteDataSource.fetchReminders();
}
