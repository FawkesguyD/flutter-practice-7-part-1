class Habit {
  final String id;
  final String title;
  final String description;
  final List<String> reminders;
  final List<String> steps;
  final String imageUrl;
  final int focusMinutes;
  final String frequency;

  const Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.reminders,
    required this.steps,
    required this.imageUrl,
    required this.focusMinutes,
    required this.frequency,
  });

  String get focusSummary => "$focusMinutes мин · $frequency";
}
