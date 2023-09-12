import 'package:flutter/material.dart';

import '../model/order_model.dart';

class OrderDetailProvider extends ChangeNotifier{
  List<OrderModel> _lstOrder=[];
  String _tableName="";

  List<OrderModel> get lstOrder=>_lstOrder;
  String get tableName=>_tableName;

  void setOrderList(List<OrderModel> lstOrder){
    _lstOrder=lstOrder;
    notifyListeners();
  }

  void setTableName(String tableName){
    _tableName=tableName;
    notifyListeners();
  }
}