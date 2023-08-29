import 'package:flutter/material.dart';

import '../model/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _lstOrder = [];
  late Map<String, dynamic> _selectedTable = {"tableId": 0, "tableName": "-"};

  List<OrderModel> get lstOrder => _lstOrder;
  Map<String, dynamic> get selectedTable => _selectedTable;

  void addOrder(OrderModel orderModel) {
    _lstOrder.add(orderModel);
    notifyListeners();
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

  void setSelectedTable(Map<String, dynamic> selectedTable) {
    _selectedTable = selectedTable;
    notifyListeners();
  }

  void updateCommonTaste(int index, String tastes) {
    _lstOrder[index].commonTaste = tastes;
    notifyListeners();
  }

  void updateTasteByItem(int index, String tastes) {
    _lstOrder[index].tasteByItem = tastes;
    notifyListeners();
  }
}
