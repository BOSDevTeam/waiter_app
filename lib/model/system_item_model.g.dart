// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemItemModel _$SystemItemModelFromJson(Map<String, dynamic> json) =>
    SystemItemModel(
      systemId: json['SystemID'] as int,
      itemId: json['ItemID'] as String,
    );

Map<String, dynamic> _$SystemItemModelToJson(SystemItemModel instance) =>
    <String, dynamic>{
      'SystemID': instance.systemId,
      'ItemID': instance.itemId,
    };
