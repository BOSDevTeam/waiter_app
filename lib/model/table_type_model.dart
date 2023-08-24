import 'package:json_annotation/json_annotation.dart';

part 'table_type_model.g.dart';

@JsonSerializable()
class TableTypeModel{

  @JsonKey(name: "TableTypeID")
  int tableTypeId;
  @JsonKey(name: "TableTypeName")
  String tableTypeName;

  TableTypeModel({required this.tableTypeId,required this.tableTypeName});

  factory TableTypeModel.fromJson(Map<String, dynamic> json) => _$TableTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$TableTypeModelToJson(this);

}