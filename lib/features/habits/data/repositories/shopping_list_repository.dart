import "package:prac7/features/habits/data/models/habit_model.dart";
import "package:prac7/features/habits/data/repositories/habit_repository.dart";

class ShoppingListRepository {
  final HabitRepository _repo;
  final List<String> _selectedHabitIds = ["102", "104"];

  ShoppingListRepository(this._repo);

  Future<List<Habit>> getSelectedHabits() async {
    final futures = _selectedHabitIds.map((id) => _repo.getById(id));
    return Future.wait(futures);
  }

  Future<List<String>> getCombinedReminders() async {
    final habits = await getSelectedHabits();
    final items = <String>[];
    for (final habit in habits) {
      items.addAll(habit.reminders);
    }
    return items.toSet().toList();
  }
}
