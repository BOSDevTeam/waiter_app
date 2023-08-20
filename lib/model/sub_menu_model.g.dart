// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubMenuModel _$SubMenuModelFromJson(Map<String, dynamic> json) => SubMenuModel(
      subMenuId: json['SubMenuID'] as int,
      mainMenuId: json['MainMenuID'] as int,
      subMenuName: json['SubMenuName'] as String,
      incomId: json['IncomeID'] as int,
    );

Map<String, dynamic> _$SubMenuModelToJson(SubMenuModel instance) =>
    <String, dynamic>{
      'SubMenuID': instance.subMenuId,
      'MainMenuID': instance.mainMenuId,
      'SubMenuName': instance.subMenuName,
      'IncomeID': instance.incomId,
    };
