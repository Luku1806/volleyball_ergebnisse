import 'package:json_annotation/json_annotation.dart';

part 'tenant.g.dart';

@JsonSerializable()
class Tenant {
  final int id;
  final String name;
  final String shortName;
  final String email;
  final bool active;

  Tenant(this.id, this.name, this.shortName, this.email, this.active);

  factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);

  Map<String, dynamic> toJson() => _$TenantToJson(this);
}
