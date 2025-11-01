import "../models/habit_model.dart";
import "habit_repository.dart";

class FavoritesRepository {
  final HabitRepository _repo;
  final List<String> _favIds = ["101", "106"];

  FavoritesRepository(this._repo);

  Future<List<Habit>> getFavorites() async {
    final futures = _favIds.map((id) => _repo.getById(id));
    return Future.wait(futures);
  }
}
