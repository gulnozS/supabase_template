import 'package:flutter/material.dart';
import 'package:supabase_template/src/features/reminders/domain/entities/reminder.dart';

class ReminderTile extends StatelessWidget {
  const ReminderTile({super.key, required this.reminder});

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    final dueAtText = reminder.dueAt?.toLocal().toString() ?? 'No due date';
    return Card(
      child: ListTile(
        leading: const Icon(Icons.notifications_active_outlined),
        title: Text(reminder.title),
        subtitle: Text(
          '${reminder.description ?? 'No description'}\nDue: $dueAtText',
        ),
        isThreeLine: true,
      ),
    );
  }
}
