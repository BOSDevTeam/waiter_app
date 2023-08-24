import 'package:json_annotation/json_annotation.dart';

part 'taste_model.g.dart';

@JsonSerializable()
class TasteModel{

  @JsonKey(name: "TasteID")
  int tasteId;
  @JsonKey(name: "TasteName")
  String tasteName;

  TasteModel({required this.tasteId,required this.tasteName});

  factory TasteModel.fromJson(Map<String, dynamic> json) => _$TasteModelFromJson(json);
  Map<String, dynamic> toJson() => _$TasteModelToJson(this);

}