// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemSettingModel _$SystemSettingModelFromJson(Map<String, dynamic> json) =>
    SystemSettingModel(
      tax: json['Tax'] as int,
      service: json['Service'] as int,
      adminPassword: json['AdminPassword'] as String,
      title: json['Title'] as String,
      userPassword: json['Userpassword'] as String,
    );

Map<String, dynamic> _$SystemSettingModelToJson(SystemSettingModel instance) =>
    <String, dynamic>{
      'Tax': instance.tax,
      'Service': instance.service,
      'AdminPassword': instance.adminPassword,
      'Title': instance.title,
      'Userpassword': instance.userPassword,
    };
