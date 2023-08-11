import 'package:json_annotation/json_annotation.dart';

part 'waiter_model.g.dart';

@JsonSerializable()
class WaiterModel{

  @JsonKey(name: "WaiterID")
  int waiterId;
  @JsonKey(name: "WaiterName")
  String waiterName;
  @JsonKey(name: "Password")
  String password;

  WaiterModel({required this.waiterId,required this.waiterName,required this.password});

  factory WaiterModel.fromJson(Map<String, dynamic> json) => _$WaiterModelFromJson(json);
  Map<String, dynamic> toJson() => _$WaiterModelToJson(this);

}