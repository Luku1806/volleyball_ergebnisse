import 'dart:convert';

import 'package:handball_ergebnisse/domain/class.dart';
import 'package:handball_ergebnisse/domain/repositories/team.dart';
import 'package:handball_ergebnisse/domain/team.dart';

import 'api_http_client.dart';

class VolleyballErgebnisseTeamRepository implements TeamRepository {
  @override
  Future<List<Team>> getAll(String tenant, int leagueId) async {
    final client = HandballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/teams/$tenant/$leagueId',
      ),
    );

    final teamDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return teamDtos.map((teamDto) => Team.fromJson(teamDto)).toList();
  }
}
