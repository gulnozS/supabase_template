import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_template/src/core/error/app_exception.dart';
import 'package:supabase_template/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:supabase_template/src/features/reminders/data/datasources/reminder_remote_data_source.dart';
import 'package:supabase_template/src/features/reminders/data/repositories/reminder_repository_impl.dart';
import 'package:supabase_template/src/features/reminders/domain/entities/reminder.dart';
import 'package:supabase_template/src/features/reminders/domain/repositories/reminder_repository.dart';
import 'package:supabase_template/src/features/reminders/domain/usecases/get_reminders_use_case.dart';

/// DI: reminders data source + repository + use-case.
final reminderRemoteDataSourceProvider = Provider<ReminderRemoteDataSource>(
  (ref) => ReminderRemoteDataSource(ref.watch(supabaseClientProvider)),
);

final reminderRepositoryProvider = Provider<ReminderRepository>(
  (ref) => ReminderRepositoryImpl(ref.watch(reminderRemoteDataSourceProvider)),
);

final getRemindersUseCaseProvider = Provider<GetRemindersUseCase>(
  (ref) => GetRemindersUseCase(ref.watch(reminderRepositoryProvider)),
);

/// Async reminders list state consumed by the screen.
final remindersProvider = FutureProvider<List<Reminder>>(
  (ref) => ref.watch(getRemindersUseCaseProvider).call(),
);

String mapReminderError(Object error) {
  if (error is AppException) return error.message;
  return 'Unexpected error while loading reminders.';
}
