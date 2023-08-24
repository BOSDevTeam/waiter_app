import 'package:json_annotation/json_annotation.dart';

part 'taste_multi_model.g.dart';

@JsonSerializable()
class TasteMultiModel {
  @JsonKey(name: "TID")
  int tId;
  @JsonKey(name: "GroupID")
  int groupId;
  @JsonKey(name: "TasteID")
  int tasteId;
  @JsonKey(name: "TasteName")
  String tasteName;
  @JsonKey(name: "TasteShort")
  String tasteShort;
  @JsonKey(name: "TasteSort")
  int tasteSort;
  @JsonKey(name: "Price")
  int price;

  TasteMultiModel(
      {required this.tId,
      required this.groupId,
      required this.tasteId,
      required this.tasteName,
      required this.tasteShort,
      required this.tasteSort,
      required this.price,});

  factory TasteMultiModel.fromJson(Map<String, dynamic> json) =>
      _$TasteMultiModelFromJson(json);
  Map<String, dynamic> toJson() => _$TasteMultiModelToJson(this);
}
