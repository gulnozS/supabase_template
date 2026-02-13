import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_template/src/features/reminders/data/models/reminder_model.dart';

void main() {
  test('ReminderModel parses json payload', () {
    final model = ReminderModel.fromJson({
      'id': 'abc',
      'title': 'Pay rent',
      'description': 'Before 5 PM',
      'due_at': '2026-01-01T10:00:00.000Z',
    });

    expect(model.id, 'abc');
    expect(model.title, 'Pay rent');
    expect(model.description, 'Before 5 PM');
    expect(model.dueAt?.toUtc().toIso8601String(), '2026-01-01T10:00:00.000Z');
  });
}
