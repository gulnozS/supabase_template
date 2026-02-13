import 'package:supabase_template/src/features/reminders/domain/entities/reminder.dart';

class ReminderModel extends Reminder {
  const ReminderModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dueAt,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      dueAt: json['due_at'] == null
          ? null
          : DateTime.parse(json['due_at'] as String),
    );
  }
}
