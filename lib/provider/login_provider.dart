import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../value/app_string.dart';

class LoginProvider extends ChangeNotifier {
  final passwordController = TextEditingController();
  List<Map<String, dynamic>> _lstWaiter = [];
  Map<String, dynamic> _selectedWaiter = {
    "WaiterID": 0,
    "WaiterName": "",
  };

  List<Map<String, dynamic>> get lstWaiter => _lstWaiter;

  Map<String, dynamic> get selectedWaiter => _selectedWaiter;

  void setWaiterList(List<Map<String, dynamic>> lstWaiter) {
    _lstWaiter = lstWaiter;
    notifyListeners();
  }

  void setSelectedWaiter(Map<String, dynamic> selectedWaiter) {
    _selectedWaiter = selectedWaiter;
    notifyListeners();
  }

  Future<bool> authenticate() async {
    if (isValidateControl()) {
      int waiterId = _selectedWaiter["waiterId"];
      String waiterName = _selectedWaiter["waiterName"];

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setInt("WaiterID", waiterId);
      sharedPreferences.setString("WaiterName", waiterName);

      return true;
    }
    return false;
  }

  bool isValidateControl() {
    String password = "";
    String inputPassword = passwordController.text;
    if (_lstWaiter.isNotEmpty) {
      password = _selectedWaiter["password"];
    }

    if (_lstWaiter.isEmpty) {
      Fluttertoast.showToast(msg: AppString.notFoundWaiter);
      return false;
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterPassword);
      return false;
    } else if (password != inputPassword) {
      Fluttertoast.showToast(msg: AppString.invalidLogin);
      return false;
    }
    return true;
  }
}
