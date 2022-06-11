import 'dart:convert';

import 'package:volleyball_ergebnisse/domain/district.dart';
import 'package:volleyball_ergebnisse/domain/repositories/district.dart';

import 'api_http_client.dart';

class VolleyballErgebnisseDistrictRepository implements DistrictRepository {
  @override
  Future<List<District>> getAll(String tenant, int classId) async {
    final client = VolleyballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${VolleyballErgebnisseApiHttpClient.BASE_URL}/districts/$tenant/$classId',
      ),
    );

    final districtDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return districtDtos
        .map((districtDto) => District.fromJson(districtDto))
        .toList();
  }
}
