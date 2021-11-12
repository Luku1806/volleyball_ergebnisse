// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      json['id'] as int,
      json['name'] as String,
      json['tenant'] as String,
      json['leagueId'] as int,
      json['placement'] as int,
      json['points'] as int,
      json['lostSets'] as int,
      json['wonSets'] as int,
      json['games'] as int,
      json['gamesLost'] as int,
      json['gamesTie'] as int,
      json['gamesWon'] as int,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tenant': instance.tenant,
      'leagueId': instance.leagueId,
      'placement': instance.placement,
      'points': instance.points,
      'lostSets': instance.lostSets,
      'wonSets': instance.wonSets,
      'games': instance.games,
      'gamesLost': instance.gamesLost,
      'gamesTie': instance.gamesTie,
      'gamesWon': instance.gamesWon,
    };
