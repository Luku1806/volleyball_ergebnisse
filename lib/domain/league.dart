import 'package:json_annotation/json_annotation.dart';

part 'league.g.dart';

@JsonSerializable()
class League {
  final int id;
  final String tenantId;
  final int classId;
  final int districtId;

  final String name;
  final int? winningSets;

  League(
    this.id,
    this.tenantId,
    this.classId,
    this.districtId,
    this.name,
    this.winningSets,
  );

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueToJson(this);
}
