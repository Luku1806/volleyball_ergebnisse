import 'dart:convert';

import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/repositories/league.dart';

import 'api_http_client.dart';

class VolleyballErgebnisseLeagueRepository extends LeagueRepository {
  @override
  Future<List<League>> getAllByClass(String tenant, int classId) async {
    final client = HandballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/leagues/$tenant/$classId',
      ),
    );

    final leaguesDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return leaguesDtos.map((leagueDto) => League.fromJson(leagueDto)).toList();
  }

  @override
  Future<List<League>> getAllByDistrict(
    String tenant,
    int classId,
    int districtId,
  ) async {
    final client = HandballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/leagues/$tenant/$classId/$districtId',
      ),
    );

    final leaguesDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return leaguesDtos.map((leagueDto) => League.fromJson(leagueDto)).toList();
  }
}
