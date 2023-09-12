// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMasterModel _$OrderMasterModelFromJson(Map<String, dynamic> json) =>
    OrderMasterModel(
      waiterId: json['WaiterID'] as int,
      waiterName: json['WaiterName'] as String,
      tableId: json['TableID'] as int,
      tableName: json['TableName'] as String,
      isOccupiedTable: json['IsOccupiedTable'] as bool,
      isAddStartTimeInOrder: json['IsAddStartTimeInOrder'] as bool,
      startTime: json['StartTime'] as String,
      isAddTimeByItemInOrder: json['IsAddTimeByItemInOrder'] as bool,
      currentTime: json['CurrentTime'] as String,
      notPutTogetherItemNameAndTaste:
          json['NotPutTogetherItemNameAndTaste'] as bool,
      lstOrder: (json['lstOrder'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      connectorModel: ConnectorModel.fromJson(
          json['connectorModel'] as Map<String, dynamic>),
      tranId: json['TranID'] as int? ?? 0,
      totalCustomer: json['TotalCustomer'] as int? ?? 0,
    );

Map<String, dynamic> _$OrderMasterModelToJson(OrderMasterModel instance) =>
    <String, dynamic>{
      'WaiterID': instance.waiterId,
      'WaiterName': instance.waiterName,
      'TableID': instance.tableId,
      'TableName': instance.tableName,
      'IsOccupiedTable': instance.isOccupiedTable,
      'IsAddStartTimeInOrder': instance.isAddStartTimeInOrder,
      'StartTime': instance.startTime,
      'IsAddTimeByItemInOrder': instance.isAddTimeByItemInOrder,
      'CurrentTime': instance.currentTime,
      'NotPutTogetherItemNameAndTaste': instance.notPutTogetherItemNameAndTaste,
      'lstOrder': instance.lstOrder,
      'connectorModel': instance.connectorModel,
      'TranID': instance.tranId,
      'TotalCustomer': instance.totalCustomer,
    };
