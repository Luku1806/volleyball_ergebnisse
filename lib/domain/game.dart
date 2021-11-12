import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  final int id;
  final int gameNumber;

  final Gymnasium gymnasium;
  final TeamScore team1, team2;
  final List<String> sets;
  final DateTime openingTime;
  final DateTime startTime;
  final String comment;

  Game(
    this.id,
    this.gameNumber,
    this.gymnasium,
    this.team1,
    this.team2,
    this.sets,
    this.openingTime,
    this.startTime,
    this.comment,
  );

  bool get isOver => startTime.add(Duration(hours: 3)).isBefore(DateTime.now());

  bool get hasData => sets.length != 0;

  int get homeTeamId => team1.isHost ? team1.id : team2.id;
  int get winnerTeamId => team1.points > team2.points ? team1.id : team2.id;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}

@JsonSerializable()
class TeamScore {
  final int id;
  final String name;
  final int points;
  final bool isHost;

  TeamScore(this.id, this.name, this.points, this.isHost);

  factory TeamScore.fromJson(Map<String, dynamic> json) =>
      _$TeamScoreFromJson(json);

  Map<String, dynamic> toJson() => _$TeamScoreToJson(this);
}

@JsonSerializable()
class Gymnasium {
  final int id;
  final String name;
  final String zip;
  final String city;
  final String street;
  final double? lat, lon;

  Gymnasium(
      this.id, this.name, this.zip, this.city, this.street, this.lat, this.lon);

  factory Gymnasium.fromJson(Map<String, dynamic> json) =>
      _$GymnasiumFromJson(json);

  Map<String, dynamic> toJson() => _$GymnasiumToJson(this);
}
