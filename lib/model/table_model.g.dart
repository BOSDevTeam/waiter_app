// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableModel _$TableModelFromJson(Map<String, dynamic> json) => TableModel(
      tableId: json['TableID'] as int,
      tableName: json['TableName'] as String,
      tableTypeId: json['TableTypeID'] as int,
    );

Map<String, dynamic> _$TableModelToJson(TableModel instance) =>
    <String, dynamic>{
      'TableID': instance.tableId,
      'TableName': instance.tableName,
      'TableTypeID': instance.tableTypeId,
    };
