import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: "ItemID")
  String itemId;
  @JsonKey(name: "ItemName")
  String itemName;
  @JsonKey(name: "CommonTaste")
  String commonTaste;
  @JsonKey(name: "TasteByItem")
  String tasteByItem;
  @JsonKey(name: "Quantity")
  int quantity;
  @JsonKey(name: "IncomeID")
  int incomdId;
  @JsonKey(name: "Number")
  int number;
  @JsonKey(name: "SalePrice")
  int salePrice;
  @JsonKey(name: "TotalTastePrice")
  int totalTastePrice;
  @JsonKey(name: "SystemID")
  int systemId;
  @JsonKey(name: "CounterID")
  int counterId;
  @JsonKey(name: "SType")
  int sType;
  @JsonKey(name: "NoDiscount")
  int noDiscount;
  @JsonKey(name: "ItemDiscount")
  int itemDiscount;

  OrderModel(
      {required this.itemId,
      required this.itemName,
      this.commonTaste = "",
      this.tasteByItem = "",
      required this.quantity,
      required this.incomdId,
      this.number = 0,
      required this.salePrice,
      this.totalTastePrice = 0,
      required this.systemId,
      required this.counterId,
      required this.sType,
      required this.noDiscount,
      required this.itemDiscount});

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
