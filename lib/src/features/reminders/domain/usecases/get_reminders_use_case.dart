import 'package:supabase_template/src/features/reminders/domain/entities/reminder.dart';
import 'package:supabase_template/src/features/reminders/domain/repositories/reminder_repository.dart';

class GetRemindersUseCase {
  const GetRemindersUseCase(this._repository);

  final ReminderRepository _repository;

  Future<List<Reminder>> call() => _repository.fetchReminders();
}
