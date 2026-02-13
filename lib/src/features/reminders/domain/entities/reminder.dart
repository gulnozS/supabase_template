class Reminder {
  const Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.dueAt,
  });

  final String id;
  final String title;
  final String? description;
  final DateTime? dueAt;
}
