import "package:flutter/material.dart";
import "../../data/repositories/habit_repository.dart";
import "../../data/repositories/shopping_list_repository.dart";
import "../widgets/habit_card.dart";
import "../../data/models/habit_model.dart";

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});
  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  late final ShoppingListRepository _repo;

  @override
  void initState() {
    super.initState();
    _repo = ShoppingListRepository(HabitRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Поддержка привычек"),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: FutureBuilder<List<Habit>>(
        future: _repo.getSelectedHabits(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Ошибка загрузки: ${snap.error}'));
          }
          final habits = snap.data ?? const <Habit>[];

          return Column(
            children: [
              Expanded(
                child: habits.isEmpty
                    ? const Center(child: Text("Пока пусто"))
                    : ListView.builder(
                        itemCount: habits.length,
                        padding: const EdgeInsets.only(top: 8),
                        itemBuilder: (context, i) => HabitCard(habit: habits[i], onTap: () {}),
                      ),
              ),
              FutureBuilder<List<String>>(
                future: _repo.getCombinedReminders(),
                builder: (context, ingSnap) {
                  if (ingSnap.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  }
                  final reminders = ingSnap.data ?? const <String>[];
                  if (reminders.isEmpty) return const SizedBox.shrink();

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        "Напоминания по выбранным привычкам",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      ...reminders.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text("• $e"),
                          )),
                    ]),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
