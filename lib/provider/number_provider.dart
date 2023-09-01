import 'package:flutter/material.dart';

class NumberProvider extends ChangeNotifier {
  final numberController = TextEditingController();
  String _num = "";

  String get num => _num;

  void setNumber(String number) {
    if (number == "0" && _num.isEmpty) return;

    _num = _num + number;
    numberController.text = _num;
    notifyListeners();
  }

  void clearNumber() {
    _num = "";
    numberController.text = _num;
    notifyListeners();
  }

  void deleteNumber() {
    if (_num.isNotEmpty) {
      _num = _num.substring(0, _num.length - 1);
      numberController.text = _num;
      notifyListeners();
    }
  }
}
