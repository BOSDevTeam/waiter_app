import 'package:json_annotation/json_annotation.dart';

part 'system_setting_model.g.dart';

@JsonSerializable()
class SystemSettingModel {
  @JsonKey(name: "Tax")
  int tax;
  @JsonKey(name: "Service")
  int service;
  @JsonKey(name: "AdminPassword")
  String adminPassword;
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "Userpassword")
  String userPassword;

  SystemSettingModel(
      {required this.tax,
      required this.service,
      required this.adminPassword,
      required this.title,
      required this.userPassword});

  factory SystemSettingModel.fromJson(Map<String, dynamic> json) =>
      _$SystemSettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$SystemSettingModelToJson(this);
}
