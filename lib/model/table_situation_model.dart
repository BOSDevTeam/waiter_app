import 'package:json_annotation/json_annotation.dart';

part 'table_situation_model.g.dart';

@JsonSerializable()
class TableSituationModel{

  @JsonKey(name: "TableID")
  int tableId;
  @JsonKey(name: "TableName")
  String tableName;
  @JsonKey(name: "IsOccupied")
  bool isOccupied;

  TableSituationModel({required this.tableId,required this.tableName,required this.isOccupied});

  factory TableSituationModel.fromJson(Map<String, dynamic> json) => _$TableSituationModelFromJson(json);
  Map<String, dynamic> toJson() => _$TableSituationModelToJson(this);

}