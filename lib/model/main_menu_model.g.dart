// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainMenuModel _$MainMenuModelFromJson(Map<String, dynamic> json) =>
    MainMenuModel(
      mainMenuId: json['MainMenuID'] as int,
      mainMenuName: json['MainMenuName'] as String,
      counterId: json['CounterID'] as int,
    );

Map<String, dynamic> _$MainMenuModelToJson(MainMenuModel instance) =>
    <String, dynamic>{
      'MainMenuID': instance.mainMenuId,
      'MainMenuName': instance.mainMenuName,
      'CounterID': instance.counterId,
    };
