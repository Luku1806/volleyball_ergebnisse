import 'dart:convert';

import 'package:volleyball_ergebnisse/domain/tenant.dart';
import 'package:volleyball_ergebnisse/domain/repositories/tenant.dart';

import 'api_http_client.dart';

class VolleyballErgebnisseTenantRepository implements TenantRepository {
  @override
  Future<List<Tenant>> getAll() async {
    final client = VolleyballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse('${VolleyballErgebnisseApiHttpClient.BASE_URL}/tenants'),
    );

    final tenantDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return tenantDtos
        .map((associationDto) => Tenant.fromJson(associationDto))
        .toList();
  }
}
