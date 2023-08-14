import 'package:json_annotation/json_annotation.dart';

part 'connector_model.g.dart';

@JsonSerializable()
class ConnectorModel{
  @JsonKey(name: "IPAddress")
  String ipAddress;
  @JsonKey(name: "DatabaseName")
  String databaseName;
  @JsonKey(name: "DatabaseLoginUser")
  String databaseLoginUser;
  @JsonKey(name: "DatabaseLoginPassword")
  String databaseLoginPassword;

  ConnectorModel({required this.ipAddress,required this.databaseName,required this.databaseLoginUser,required this.databaseLoginPassword});

  factory ConnectorModel.fromJson(Map<String, dynamic> json) => _$ConnectorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectorModelToJson(this);
}