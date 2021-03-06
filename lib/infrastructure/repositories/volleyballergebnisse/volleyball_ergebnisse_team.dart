import 'dart:convert';

import 'package:volleyball_ergebnisse/domain/class.dart';
import 'package:volleyball_ergebnisse/domain/repositories/team.dart';
import 'package:volleyball_ergebnisse/domain/team.dart';

import 'api_http_client.dart';

class VolleyballErgebnisseTeamRepository implements TeamRepository {
  @override
  Future<List<Team>> getAll(String tenant, int leagueId) async {
    final client = VolleyballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${VolleyballErgebnisseApiHttpClient.BASE_URL}/teams/$tenant/$leagueId',
      ),
    );

    final teamDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return teamDtos.map((teamDto) => Team.fromJson(teamDto)).toList();
  }
}
