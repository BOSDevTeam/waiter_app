// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      itemId: json['ItemID'] as String,
      subMenuId: json['SubMenuID'] as int,
      itemName: json['ItemName'] as String,
      salePrice: (json['SalePrice'] as num).toDouble(),
      sType: json['SType'] as int,
      outOfOrder: json['OutOfOrder'] as int,
      ingredients: json['Ingredients'] as String,
      barcode: json['Barcode'] as String,
      noDiscount: json['NoDiscount'] as int,
      itemDiscount: json['ItemDiscount'] as int,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'ItemID': instance.itemId,
      'SubMenuID': instance.subMenuId,
      'ItemName': instance.itemName,
      'SalePrice': instance.salePrice,
      'SType': instance.sType,
      'OutOfOrder': instance.outOfOrder,
      'Ingredients': instance.ingredients,
      'Barcode': instance.barcode,
      'NoDiscount': instance.noDiscount,
      'ItemDiscount': instance.itemDiscount,
    };
