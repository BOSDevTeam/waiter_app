// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableTypeModel _$TableTypeModelFromJson(Map<String, dynamic> json) =>
    TableTypeModel(
      tableTypeId: json['TableTypeID'] as int,
      tableTypeName: json['TableTypeName'] as String,
    );

Map<String, dynamic> _$TableTypeModelToJson(TableTypeModel instance) =>
    <String, dynamic>{
      'TableTypeID': instance.tableTypeId,
      'TableTypeName': instance.tableTypeName,
    };
