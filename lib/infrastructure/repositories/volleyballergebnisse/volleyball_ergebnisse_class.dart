import 'dart:convert';

import 'package:volleyball_ergebnisse/domain/class.dart';
import 'package:volleyball_ergebnisse/domain/repositories/class.dart';

import 'api_http_client.dart';

class VolleyballErgebnisseClassRepository implements ClassRepository {
  @override
  Future<List<Class>> getAll(
    String tenant,
  ) async {
    final client = VolleyballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${VolleyballErgebnisseApiHttpClient.BASE_URL}/classes/$tenant',
      ),
    );

    final classDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return classDtos.map((classDto) => Class.fromJson(classDto)).toList();
  }
}
