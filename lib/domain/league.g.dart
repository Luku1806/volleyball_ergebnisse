// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

League _$LeagueFromJson(Map<String, dynamic> json) => League(
      json['id'] as int,
      json['tenantId'] as String,
      json['classId'] as int,
      json['districtId'] as int,
      json['name'] as String,
      json['winningSets'] as int?,
    );

Map<String, dynamic> _$LeagueToJson(League instance) => <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'classId': instance.classId,
      'districtId': instance.districtId,
      'name': instance.name,
      'winningSets': instance.winningSets,
    };
