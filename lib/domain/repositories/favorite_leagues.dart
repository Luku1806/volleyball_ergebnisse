import '../league.dart';

abstract class FavoriteLeaguesRepository {
  Future<void> add(League league);

  Future<void> remove(int id);

  Future<List<League>> getAll();
}
