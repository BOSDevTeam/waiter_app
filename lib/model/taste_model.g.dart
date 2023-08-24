// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasteModel _$TasteModelFromJson(Map<String, dynamic> json) => TasteModel(
      tasteId: json['TasteID'] as int,
      tasteName: json['TasteName'] as String,
    );

Map<String, dynamic> _$TasteModelToJson(TasteModel instance) =>
    <String, dynamic>{
      'TasteID': instance.tasteId,
      'TasteName': instance.tasteName,
    };
