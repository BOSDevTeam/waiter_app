import 'package:json_annotation/json_annotation.dart';

part 'sub_menu_model.g.dart';

@JsonSerializable()
class SubMenuModel{

  @JsonKey(name: "SubMenuID")
  int subMenuId;
  @JsonKey(name: "MainMenuID")
  int mainMenuId;
  @JsonKey(name: "SubMenuName")
  String subMenuName;
  @JsonKey(name: "IncomeID")
  int incomeId;

  SubMenuModel({required this.subMenuId,required this.mainMenuId,required this.subMenuName,required this.incomeId});

  factory SubMenuModel.fromJson(Map<String, dynamic> json) => _$SubMenuModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubMenuModelToJson(this);

}