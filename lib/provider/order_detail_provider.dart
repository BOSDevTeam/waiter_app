import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:waiter_app/database/database_helper.dart';

import '../model/order_model.dart';

class OrderDetailProvider extends ChangeNotifier {
  List<OrderModel> _lstOrder = [];
  String _startTime = "";
  int _subtotal = 0;
  int _taxAmount = 0;
  int _chargesAmount = 0;
  int _total = 0;
  bool _isHideCommercialTax = false;

  List<OrderModel> get lstOrder => _lstOrder;
  String get startTime => _startTime;
  int get subtotal => _subtotal;
  int get taxAmount => _taxAmount;
  int get chargesAmount => _chargesAmount;
  int get total => _total;
  bool get isHideCommercialTax => _isHideCommercialTax;

  void setOrderList(List<OrderModel> lstOrder, bool isCalculateAdvancedTax,
      bool isHideCommercialTax) {
    _lstOrder = lstOrder;
    _isHideCommercialTax = isHideCommercialTax;
    notifyListeners();
    calculateAmount(lstOrder, isCalculateAdvancedTax, isHideCommercialTax);
  }

  void calculateAmount(List<OrderModel> lstOrder, bool isCalculateAdvancedTax,
      bool isHideCommercialTax) {
    int subtotal = 0, taxPercent = 0, chargesPercent = 0;
    double taxAmount = 0, chargesAmount = 0, total = 0;

    for (int i = 0; i < lstOrder.length; i++) {
      subtotal += lstOrder[i].amount;
    }

    DatabaseHelper().getSystemSetting().then((value) {
      if (value.isNotEmpty) {
        Map<String, dynamic> systemSetting = value[0];
        taxPercent = systemSetting["Tax"];
        chargesPercent = systemSetting["Service"];

        chargesAmount = (subtotal * chargesPercent) / 100;

        if (!isHideCommercialTax) {
          if (!isCalculateAdvancedTax) {
            taxAmount = (subtotal * taxPercent) / 100;
          } else {
            taxAmount = ((subtotal + chargesAmount) * taxPercent) / 100;
          }
        }

        total = subtotal + taxAmount + chargesAmount;
      } else {
        total = double.parse(subtotal.toString());
      }

      _subtotal = subtotal;
      _taxAmount = taxAmount.ceil();
      _chargesAmount = chargesAmount.ceil();
      _total = total.ceil();
      notifyListeners();
    });
  }

  void setStartTime(String startTime) {
    _startTime = startTime;
    notifyListeners();
  }
}
