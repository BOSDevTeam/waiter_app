import 'package:flutter/material.dart';

class CustomerProvider extends ChangeNotifier {
  final manController = TextEditingController();
  final womenController = TextEditingController();
  final childController = TextEditingController();
  final totalCustomerController = TextEditingController();

  bool _isAddCustomerByTotalPerson = false;
  String _time = "";
  String _date = "";

  bool get isAddCustomerByTotalPerson => _isAddCustomerByTotalPerson;
  String get time => _time;
  String get date => _date;

  void setIsAddCustomerByTotalPerson(bool result) {
    _isAddCustomerByTotalPerson = result;
    notifyListeners();
  }

  void setTime(String time, bool isNotify) {
    _time = time;
    if (isNotify) notifyListeners();
  }

  void setDate(String date, bool isNotify) {
    _date = date;
    if (isNotify) notifyListeners();
  }
}
