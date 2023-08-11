// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaiterModel _$WaiterModelFromJson(Map<String, dynamic> json) => WaiterModel(
      waiterId: json['WaiterID'] as int,
      waiterName: json['WaiterName'] as String,
      password: json['Password'] as String,
    );

Map<String, dynamic> _$WaiterModelToJson(WaiterModel instance) =>
    <String, dynamic>{
      'WaiterID': instance.waiterId,
      'WaiterName': instance.waiterName,
      'Password': instance.password,
    };
