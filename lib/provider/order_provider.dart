import 'package:flutter/material.dart';

import '../model/order_model.dart';
import '../model/menu_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _lstOrder = [];
  late Map<String, dynamic> _selectedTable = {"tableId": 0, "tableName": "-"};
  List<MenuModel> _lstMenu = [];

  List<OrderModel> get lstOrder => _lstOrder;
  Map<String, dynamic> get selectedTable => _selectedTable;
  List<MenuModel> get lstMenu => _lstMenu;

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

  void updateTasteByItem(int index, String tastes) {
    _lstOrder[index].tasteByItem = tastes;
    notifyListeners();
  }

  void deleteOrder(int index) {
    _lstOrder.removeAt(index);
    notifyListeners();
  }

  void setMenu(List<MenuModel> lstMenu) {
    _lstMenu = lstMenu;
    notifyListeners();
  }
}
