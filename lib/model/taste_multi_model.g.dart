// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_multi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasteMultiModel _$TasteMultiModelFromJson(Map<String, dynamic> json) =>
    TasteMultiModel(
      tId: json['TID'] as int,
      groupId: json['GroupID'] as int,
      tasteId: json['TasteID'] as int,
      tasteName: json['TasteName'] as String,
      tasteShort: json['TasteShort'] as String,
      tasteSort: json['TasteSort'] as int,
      price: json['Price'] as int,
    );

Map<String, dynamic> _$TasteMultiModelToJson(TasteMultiModel instance) =>
    <String, dynamic>{
      'TID': instance.tId,
      'GroupID': instance.groupId,
      'TasteID': instance.tasteId,
      'TasteName': instance.tasteName,
      'TasteShort': instance.tasteShort,
      'TasteSort': instance.tasteSort,
      'Price': instance.price,
    };
