import 'package:volleyball_ergebnisse/domain/tenant.dart';

abstract class TenantRepository {
  Future<List<Tenant>> getAll();
}
