import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable()
class Team {
  final int id;
  final String name;
  final String tenant;
  final int leagueId;

  final int placement;
  final int points;

  final int lostSets;
  final int wonSets;

  final int games;
  final int gamesLost;
  final int gamesTie;
  final int gamesWon;

  Team(
    this.id,
    this.name,
    this.tenant,
    this.leagueId,
    this.placement,
    this.points,
    this.lostSets,
    this.wonSets,
    this.games,
    this.gamesLost,
    this.gamesTie,
    this.gamesWon,
  );

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
