import 'package:volleyball_ergebnisse/domain/district.dart';

abstract class DistrictRepository {
  Future<List<District>> getAll(String tenant, int districtId);
}
