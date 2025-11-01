import "package:flutter/material.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:prac7/features/habits/data/models/habit_model.dart";

class HabitDetailScreen extends StatelessWidget {
  final Habit habit;
  const HabitDetailScreen({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.title),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: habit.imageUrl,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              height: 250,
              color: colors.surfaceContainerHighest,
              child: Icon(Icons.energy_savings_leaf, size: 50, color: colors.secondary),
            ),
            errorWidget: (_, __, ___) => Container(
              height: 250,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF92A5F7), Color(0xFF6FE7DD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                habit.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                habit.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: colors.onSurface.withValues(alpha: 0.75)),
              ),
              const SizedBox(height: 12),
              Row(children: [
                Icon(Icons.timer_outlined, size: 18, color: colors.primary),
                const SizedBox(width: 6),
                Text(
                  habit.focusSummary,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ]),
              const SizedBox(height: 16),
              Text(
                "Напоминания",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              ...habit.reminders.map(
                (reminder) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, size: 18, color: colors.secondary),
                      const SizedBox(width: 8),
                      Expanded(child: Text(reminder)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Шаги",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              ...habit.steps.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text("${entry.key + 1}. ${entry.value}"),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
