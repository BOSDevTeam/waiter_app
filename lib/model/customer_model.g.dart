// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      date: json['Date'] as String,
      time: json['Time'] as String,
      man: json['Man'] as String,
      women: json['Women'] as String,
      child: json['Child'] as String,
      totalCustomer: json['TotalCustomer'] as String,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'Date': instance.date,
      'Time': instance.time,
      'Man': instance.man,
      'Women': instance.women,
      'Child': instance.child,
      'TotalCustomer': instance.totalCustomer,
    };
