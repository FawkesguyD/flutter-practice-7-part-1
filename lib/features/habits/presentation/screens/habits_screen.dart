import 'package:flutter/material.dart';
import 'package:prac7/features/habits/data/repositories/habit_repository.dart';
import 'package:prac7/features/habits/data/models/habit_model.dart';
import 'package:prac7/features/habits/presentation/widgets/habit_card.dart';
import 'package:prac7/features/habits/presentation/screens/categories_screen.dart';
import 'package:prac7/features/habits/presentation/screens/favorites_screen.dart';
import 'package:prac7/features/habits/presentation/screens/profile_screen.dart';
import 'package:prac7/features/habits/presentation/screens/habit_detail_screen.dart';
import 'package:prac7/features/habits/presentation/screens/shopping_list_screen.dart';

class HabitsScreen extends StatelessWidget {
  HabitsScreen({super.key});

  final HabitRepository _repo = HabitRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Habit Tracker"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard_customize_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CategoriesScreen()),
            ),
            tooltip: "Ритуалы",
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
            ),
            tooltip: "Избранное",
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
            tooltip: "Профиль",
          ),
        ],
      ),
      body: FutureBuilder<List<Habit>>(
        future: _repo.getAll(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Ошибка загрузки: ${snap.error}'));
          }
          final habits = snap.data ?? const <Habit>[];
          if (habits.isEmpty) {
            return const Center(
              child: Text('Пока нет привычек для отображения'),
            );
          }
          return ListView.builder(
            itemCount: habits.length,
            padding: const EdgeInsets.only(top: 8, bottom: 96),
            itemBuilder: (context, i) {
              final habit = habits[i];
              return HabitCard(
                habit: habit,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HabitDetailScreen(habit: habit),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ShoppingListScreen()),
        ),
        child: const Icon(Icons.view_list_rounded),
      ),
    );
  }
}
