// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorModel _$ConnectorModelFromJson(Map<String, dynamic> json) =>
    ConnectorModel(
      ipAddress: json['IPAddress'] as String,
      databaseName: json['DatabaseName'] as String,
      databaseLoginUser: json['DatabaseLoginUser'] as String,
      databaseLoginPassword: json['DatabaseLoginPassword'] as String,
    );

Map<String, dynamic> _$ConnectorModelToJson(ConnectorModel instance) =>
    <String, dynamic>{
      'IPAddress': instance.ipAddress,
      'DatabaseName': instance.databaseName,
      'DatabaseLoginUser': instance.databaseLoginUser,
      'DatabaseLoginPassword': instance.databaseLoginPassword,
    };
