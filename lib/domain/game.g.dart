// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      json['id'] as int,
      json['gameNumber'] as int,
      Gymnasium.fromJson(json['gymnasium'] as Map<String, dynamic>),
      TeamScore.fromJson(json['team1'] as Map<String, dynamic>),
      TeamScore.fromJson(json['team2'] as Map<String, dynamic>),
      (json['sets'] as List<dynamic>).map((e) => e as String).toList(),
      DateTime.parse(json['openingTime'] as String),
      DateTime.parse(json['startTime'] as String),
      json['comment'] as String,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'gameNumber': instance.gameNumber,
      'gymnasium': instance.gymnasium,
      'team1': instance.team1,
      'team2': instance.team2,
      'sets': instance.sets,
      'openingTime': instance.openingTime.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'comment': instance.comment,
    };

TeamScore _$TeamScoreFromJson(Map<String, dynamic> json) => TeamScore(
      json['id'] as int,
      json['name'] as String,
      json['points'] as int,
      json['isHost'] as bool,
    );

Map<String, dynamic> _$TeamScoreToJson(TeamScore instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'points': instance.points,
      'isHost': instance.isHost,
    };

Gymnasium _$GymnasiumFromJson(Map<String, dynamic> json) => Gymnasium(
      json['id'] as int,
      json['name'] as String,
      json['zip'] as String,
      json['city'] as String,
      json['street'] as String,
      (json['lat'] as num?)?.toDouble(),
      (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GymnasiumToJson(Gymnasium instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'zip': instance.zip,
      'city': instance.city,
      'street': instance.street,
      'lat': instance.lat,
      'lon': instance.lon,
    };
