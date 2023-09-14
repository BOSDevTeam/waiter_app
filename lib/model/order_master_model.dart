import 'package:json_annotation/json_annotation.dart';
import 'package:waiter_app/model/connector_model.dart';
import 'package:waiter_app/model/customer_model.dart';
import 'package:waiter_app/model/order_model.dart';

part 'order_master_model.g.dart';

@JsonSerializable()
class OrderMasterModel {
  @JsonKey(name: "WaiterID")
  int waiterId;
  @JsonKey(name: "WaiterName")
  String waiterName;
  @JsonKey(name: "TableID")
  int tableId;
  @JsonKey(name: "TableName")
  String tableName;
  @JsonKey(name: "IsOccupiedTable")
  bool isOccupiedTable;
  @JsonKey(name: "IsAddStartTimeInOrder")
  bool isAddStartTimeInOrder;
  @JsonKey(name: "StartTime")
  String startTime;
  @JsonKey(name: "IsAddTimeByItemInOrder")
  bool isAddTimeByItemInOrder;
  @JsonKey(name: "CurrentTime")
  String currentTime;
  @JsonKey(name: "NotPutTogetherItemNameAndTaste")
  bool notPutTogetherItemNameAndTaste;
  List<OrderModel> lstOrder;
  ConnectorModel connectorModel;
  @JsonKey(name: "TranID")
  int tranId;
  @JsonKey(name: "TotalCustomer")
  int totalCustomer;
  CustomerModel customerModel;

  OrderMasterModel(
      {required this.waiterId,
      required this.waiterName,
      required this.tableId,
      required this.tableName,
      required this.isOccupiedTable,
      required this.isAddStartTimeInOrder,
      required this.startTime,
      required this.isAddTimeByItemInOrder,
      required this.currentTime,
      required this.notPutTogetherItemNameAndTaste,
      required this.lstOrder,
      required this.connectorModel,
      this.tranId = 0,
      this.totalCustomer = 0,
      required this.customerModel});

  factory OrderMasterModel.fromJson(Map<String, dynamic> json) =>
      _$OrderMasterModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderMasterModelToJson(this);
}
