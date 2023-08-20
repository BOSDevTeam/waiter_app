import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  @JsonKey(name: "ItemID")
  String itemId;
  @JsonKey(name: "SubMenuID")
  int subMenuId;
  @JsonKey(name: "ItemName")
  String itemName;
  @JsonKey(name: "SalePrice")
  double salePrice;
  @JsonKey(name: "SType")
  int sType;
  @JsonKey(name: "OutOfOrder")
  int outOfOrder;
  @JsonKey(name: "Ingredients")
  String ingredients;
  @JsonKey(name: "Barcode")
  String barcode;
  @JsonKey(name: "NoDiscount")
  int noDiscount;
  @JsonKey(name: "ItemDiscount")
  int itemDiscount;

  ItemModel(
      {required this.itemId,
      required this.subMenuId,
      required this.itemName,
      required this.salePrice,
      required this.sType,
      required this.outOfOrder,
      required this.ingredients,
      required this.barcode,
      required this.noDiscount,
      required this.itemDiscount});

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
