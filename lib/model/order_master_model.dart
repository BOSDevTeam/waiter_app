class OrderMasterModel {
  int waiterId;
  String waiterName;
  int tableId;
  String tableName;
  bool isOccupiedTable;
  bool isAddStartTimeInOrder;
  String startTime;
  bool isAddTimeByItemInOrder;
  String currentTime;

  OrderMasterModel(
      {required this.waiterId,
      required this.waiterName,
      required this.tableId,
      required this.tableName,
      required this.isOccupiedTable,
      required this.isAddStartTimeInOrder,
      required this.startTime,
      required this.isAddTimeByItemInOrder,
      required this.currentTime});
}
