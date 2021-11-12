import '../team.dart';

abstract class TeamRepository {
  Future<List<Team>> getAll(String tenant, int leagueId);
}
