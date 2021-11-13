import 'package:volleyball_ergebnisse/domain/game.dart';

abstract class GameRepository {
  Future<List<Game>> getAllByLeague(String tenantId, int leagueId);

  Future<List<Game>> getAllByTeam(String tenantId, int leagueId, int teamId);
}
