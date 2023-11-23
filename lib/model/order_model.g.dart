// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      itemId: json['ItemID'] as String,
      itemName: json['ItemName'] as String,
      commonTaste: json['CommonTaste'] as String? ?? "",
      tasteByItem: json['TasteByItem'] as String? ?? "",
      inputTaste: json['InputTaste'] as String? ?? "",
      quantity: json['Quantity'] as int,
      incomdId: json['IncomeID'] as int,
      number: json['Number'] as int? ?? 0,
      salePrice: json['SalePrice'] as int,
      totalTastePrice: json['TotalTastePrice'] as int? ?? 0,
      systemId: json['SystemID'] as int,
      counterId: json['CounterID'] as int,
      sType: json['SType'] as int,
      noDiscount: json['NoDiscount'] as int,
      itemDiscount: json['ItemDiscount'] as int,
      amount: json['Amount'] as int? ?? 0,
      allTaste: json['AllTaste'] as String? ?? "",
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'ItemID': instance.itemId,
      'ItemName': instance.itemName,
      'CommonTaste': instance.commonTaste,
      'TasteByItem': instance.tasteByItem,
      'InputTaste': instance.inputTaste,
      'Quantity': instance.quantity,
      'IncomeID': instance.incomdId,
      'Number': instance.number,
      'SalePrice': instance.salePrice,
      'TotalTastePrice': instance.totalTastePrice,
      'SystemID': instance.systemId,
      'CounterID': instance.counterId,
      'SType': instance.sType,
      'NoDiscount': instance.noDiscount,
      'ItemDiscount': instance.itemDiscount,
      'Amount': instance.amount,
      'AllTaste': instance.allTaste,
    };
