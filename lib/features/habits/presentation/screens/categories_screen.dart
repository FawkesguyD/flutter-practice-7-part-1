import 'package:flutter/material.dart';
import 'package:prac7/features/habits/data/repositories/habit_repository.dart';
import 'package:prac7/features/habits/data/models/habit_model.dart';
import 'package:prac7/features/habits/presentation/widgets/habit_card.dart';
import 'package:prac7/features/habits/presentation/screens/habit_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final HabitRepository _repo = HabitRepository();
  final PageController _controller = PageController();
  int _page = 0;

  final List<String> categories = [
    "Все",
    "Утро",
    "Энергия",
    "Внимательность",
    "Работа",
    "Вечер",
  ];

  List<Habit> _filter(List<Habit> all, String c) {
    if (c == "Все") return all;
    final filters = {
      "Утро": ["утро", "старт", "просып"],
      "Энергия": ["энерг", "актив", "прогул"],
      "Внимательность": ["дыхани", "фокус", "медитац", "благодар"],
      "Работа": ["фокус", "работ", "спринт"],
      "Вечер": ["вечер", "сон"],
    };
    final keywords = filters[c] ?? [c.toLowerCase()];
    return all
        .where(
          (habit) => keywords.any(
            (keyword) =>
                habit.title.toLowerCase().contains(keyword) ||
                habit.description.toLowerCase().contains(keyword),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Категории ритуалов"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
          final all = snap.data ?? const <Habit>[];
          return Column(
            children: [
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    child: ChoiceChip(
                      label: Text(categories[i]),
                      selected: _page == i,
                      labelStyle: TextStyle(
                        color: _page == i
                            ? Theme.of(context).colorScheme.onPrimary
                            : null,
                        fontWeight: FontWeight.w600,
                      ),
                      selectedColor: Theme.of(context).colorScheme.primary,
                      onSelected: (_) {
                        setState(() {
                          _page = i;
                          _controller.animateToPage(
                            i,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        });
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _page = i),
                  children: categories.map((c) {
                    final list = _filter(all, c);
                    if (list.isEmpty) {
                      return const Center(
                        child: Text('Пусто в этой категории'),
                      );
                    }
                    return ListView.builder(
                      itemCount: list.length,
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      itemBuilder: (context, i) {
                        final habit = list[i];
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
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
