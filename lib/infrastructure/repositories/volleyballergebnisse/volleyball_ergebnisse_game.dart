import 'dart:convert';

import 'package:volleyball_ergebnisse/domain/game.dart';
import 'package:volleyball_ergebnisse/domain/repositories/game.dart';

import 'api_http_client.dart';

class VolleyballErgebnisseGameRepository extends GameRepository {
  @override
  Future<List<Game>> getAllByLeague(String tenant, int leagueId) async {
    final client = VolleyballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${VolleyballErgebnisseApiHttpClient.BASE_URL}/schedules/$tenant/$leagueId',
      ),
    );

    final gameDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return gameDtos.map((leagueDto) => Game.fromJson(leagueDto)).toList();
  }

  @override
  Future<List<Game>> getAllByTeam(
    String tenant,
    int leagueId,
    int teamId,
  ) async {
    final client = VolleyballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${VolleyballErgebnisseApiHttpClient.BASE_URL}/schedules/$tenant/$leagueId/$teamId',
      ),
    );

    final gameDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return gameDtos.map((leagueDto) => Game.fromJson(leagueDto)).toList();
  }
}
