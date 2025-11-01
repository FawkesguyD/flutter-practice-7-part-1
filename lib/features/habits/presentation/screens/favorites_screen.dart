import "package:flutter/material.dart";
import "../../data/repositories/habit_repository.dart";
import "../../data/repositories/favorites_repository.dart";
import "../widgets/habit_card.dart";
import "habit_detail_screen.dart";
import "../../data/models/habit_model.dart";

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final FavoritesRepository _favRepo;

  @override
  void initState() {
    super.initState();
    _favRepo = FavoritesRepository(HabitRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Избранное"),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: FutureBuilder<List<Habit>>(
        future: _favRepo.getFavorites(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Ошибка загрузки: ${snap.error}'));
          }
          final favs = snap.data ?? const <Habit>[];
          if (favs.isEmpty) {
            return const Center(child: Text('Нет избранных привычек'));
          }
          return ListView.builder(
            itemCount: favs.length,
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemBuilder: (context, i) {
              final habit = favs[i];
              return HabitCard(
                habit: habit,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HabitDetailScreen(habit: habit))),
              );
            },
          );
        },
      ),
    );
  }
}
