// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_situation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableSituationModel _$TableSituationModelFromJson(Map<String, dynamic> json) =>
    TableSituationModel(
      tableId: json['TableID'] as int,
      tableName: json['TableName'] as String,
      isOccupied: json['IsOccupied'] as bool,
    );

Map<String, dynamic> _$TableSituationModelToJson(
        TableSituationModel instance) =>
    <String, dynamic>{
      'TableID': instance.tableId,
      'TableName': instance.tableName,
      'IsOccupied': instance.isOccupied,
    };
