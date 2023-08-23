import 'package:flutter/material.dart';

import '../model/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _lstOrder = [];

  List<OrderModel> get lstOrder => _lstOrder;

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
}
