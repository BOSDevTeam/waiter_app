import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../value/app_string.dart';

class LoginController {
  final passwordController = TextEditingController();
  List<Map<String, dynamic>> lstWaiter = [];
  Map<String, dynamic> selectedWaiter= {"waiterId": 0, "waiterName": "-"};

  Future<bool> authenticate() async {
    if (isValidateControl()) {
      int waiterId = selectedWaiter["waiterId"];
      String waiterName = selectedWaiter["waiterName"];

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
    if (lstWaiter.isNotEmpty) {
      password = selectedWaiter["password"];
    }

    if (lstWaiter.isEmpty) {
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
