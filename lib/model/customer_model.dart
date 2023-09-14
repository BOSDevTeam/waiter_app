import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel {
  @JsonKey(name: "Date")
  String date;
  @JsonKey(name: "Time")
  String time;
  @JsonKey(name: "Man")
  String man;
  @JsonKey(name: "Women")
  String women;
  @JsonKey(name: "Child")
  String child;
  @JsonKey(name: "TotalCustomer")
  String totalCustomer;

  CustomerModel(
      {required this.date,
      required this.time,
      required this.man,
      required this.women,
      required this.child,
      required this.totalCustomer});

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
