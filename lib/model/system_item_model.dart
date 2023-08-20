import 'package:json_annotation/json_annotation.dart';

part 'system_item_model.g.dart';

@JsonSerializable()
class SystemItemModel{

  @JsonKey(name: "SystemID")
  int systemId;
  @JsonKey(name: "ItemID")
  String itemId;

  SystemItemModel({required this.systemId,required this.itemId});

  factory SystemItemModel.fromJson(Map<String, dynamic> json) => _$SystemItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SystemItemModelToJson(this);

}