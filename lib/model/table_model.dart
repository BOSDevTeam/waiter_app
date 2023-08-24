import 'package:json_annotation/json_annotation.dart';

part 'table_model.g.dart';

@JsonSerializable()
class TableModel{

  @JsonKey(name: "TableID")
  int tableId;
  @JsonKey(name: "TableName")
  String tableName;
  @JsonKey(name: "TableTypeID")
  int tableTypeId;

  TableModel({required this.tableId,required this.tableName,required this.tableTypeId});

  factory TableModel.fromJson(Map<String, dynamic> json) => _$TableModelFromJson(json);
  Map<String, dynamic> toJson() => _$TableModelToJson(this);

}