import 'package:json_annotation/json_annotation.dart';

part 'main_menu_model.g.dart';

@JsonSerializable()
class MainMenuModel {
  @JsonKey(name: "MainMenuID")
  int mainMenuId;
  @JsonKey(name: "MainMenuName")
  String mainMenuName;
  @JsonKey(name: "CounterID")
  int counterId;
  int? isOpen;

  MainMenuModel(
      {required this.mainMenuId,
      required this.mainMenuName,
      required this.counterId,
      this.isOpen});

  factory MainMenuModel.fromJson(Map<String, dynamic> json) =>
      _$MainMenuModelFromJson(json);
  Map<String, dynamic> toJson() => _$MainMenuModelToJson(this);
}
