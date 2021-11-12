import 'package:handball_ergebnisse/domain/league.dart';

abstract class LeagueRepository {
  Future<List<League>> getAllByClass(String tenant, int classId);

  Future<List<League>> getAllByDistrict(
    String tenant,
    int classId,
    int districtId,
  );
}
