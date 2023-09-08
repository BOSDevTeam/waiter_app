import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:waiter_app/controller/data_downloading_controller.dart';
import 'package:waiter_app/model/order_master_model.dart';
import 'package:dio/dio.dart';

import '../api/apiservice.dart';
import '../database/database_helper.dart';
import '../model/connector_model.dart';
import '../model/order_model.dart';
import '../model/menu_model.dart';
import '../model/waiter_model.dart';
import '../value/app_string.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _lstOrder = [];
  Map<String, dynamic> _selectedTable = {
    "tableId": 0,
    "tableName": "-",
    "isOccupied": false
  };
  List<MenuModel> _lstMenu = [];
  String _startTime = "";
  bool _isAddStartTimeInOrder = false;

  List<OrderModel> get lstOrder => _lstOrder;
  Map<String, dynamic> get selectedTable => _selectedTable;
  List<MenuModel> get lstMenu => _lstMenu;
  String get startTime => _startTime;
  bool get isAddStartTimeInOrder => _isAddStartTimeInOrder;

  int addOrder(OrderModel orderModel) {
    _lstOrder.add(orderModel);
    notifyListeners();
    return _lstOrder.length - 1;
  }

  void increaseQuantity(int index) {
    _lstOrder[index].quantity += 1;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_lstOrder[index].quantity != 1) {
      _lstOrder[index].quantity -= 1;
      notifyListeners();
    }
  }

  void changeQuantity(int index, int quantity) {
    _lstOrder[index].quantity = quantity;
    notifyListeners();
  }

  void setSelectedTable(Map<String, dynamic> selectedTable) {
    _selectedTable = selectedTable;
    notifyListeners();
  }

  void updateCommonTaste(int index, String tastes) {
    _lstOrder[index].commonTaste = tastes;
    notifyListeners();
  }

  void updateTasteByItem(int index, String tastes, int totalTastePrice) {
    _lstOrder[index].tasteByItem = tastes;
    _lstOrder[index].totalTastePrice = totalTastePrice;
    notifyListeners();
  }

  String getCommonTaste(int index) {
    String taste = _lstOrder[index].commonTaste.toString();
    return taste;
  }

  String getTasteByItem(int index) {
    String taste = _lstOrder[index].tasteByItem.toString();
    return taste;
  }

  int getTotalTastePrice(int index) {
    int totalTastePrice = _lstOrder[index].totalTastePrice;
    return totalTastePrice;
  }

  void deleteOrder(int index) {
    _lstOrder.removeAt(index);
    notifyListeners();
  }

  void setMenu(List<MenuModel> lstMenu) {
    _lstMenu = lstMenu;
    notifyListeners();
  }

  void numberOrderItem(int index, int number) {
    _lstOrder[index].number = number;
    notifyListeners();
  }

  void setStartTime(String startTime) {
    _startTime = startTime;
    notifyListeners();
  }

  void setIsAddStartTimeInOrder(bool result) {
    _isAddStartTimeInOrder = result;
    notifyListeners();
  }

  bool validateOrder() {
    if (_lstOrder.isEmpty) {
      Fluttertoast.showToast(msg: AppString.addOrder);
      return false;
    } else if (_selectedTable["tableId"] == 0) {
      Fluttertoast.showToast(msg: AppString.selectTable);
      return false;
    }
    return true;
  }

  void sendOrder(WaiterModel waiterModel, bool isAddTimeByItemInOrder) {
    var dataDownloadingController = DataDownloadingController();
    dynamic apiService;

    OrderMasterModel orderMasterModel = OrderMasterModel(
        waiterId: waiterModel.waiterId,
        waiterName: waiterModel.waiterName,
        tableId: _selectedTable["tableId"],
        tableName: _selectedTable["tableName"],
        isOccupiedTable: _selectedTable["isOccupied"],
        isAddStartTimeInOrder: _isAddStartTimeInOrder,
        startTime: _startTime,
        isAddTimeByItemInOrder: isAddTimeByItemInOrder,
        currentTime: DateFormat.jm().format(DateTime.now()));

    DatabaseHelper().getBaseUrl().then((value) {
      dataDownloadingController.lstBaseUrl = value;

      apiService = ApiService(
          dio: Dio(BaseOptions(
              baseUrl: dataDownloadingController.lstBaseUrl[0]["BaseUrl"])));

      DatabaseHelper().getConnector().then((value) {
        dataDownloadingController.lstConnector = value;
        dataDownloadingController.connectorModel = ConnectorModel(
            ipAddress: dataDownloadingController.lstConnector[0]["IPAddress"],
            databaseName: dataDownloadingController.lstConnector[0]
                ["DatabaseName"],
            databaseLoginUser: dataDownloadingController.lstConnector[0]
                ["DatabaseLoginUser"],
            databaseLoginPassword: dataDownloadingController.lstConnector[0]
                ["DatabaseLoginPassword"]);

        apiService
            .sendOrder(dataDownloadingController.connectorModel,
                orderMasterModel, lstOrder)
            .then((value) {});
      });
    });
  }
}
