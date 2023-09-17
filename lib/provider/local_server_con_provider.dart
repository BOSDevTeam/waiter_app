import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waiter_app/database/database_helper.dart';

import '../value/app_string.dart';

class LocalServerConProvider extends ChangeNotifier {
  final ipAddressController = TextEditingController();
  final databaseNameController = TextEditingController();
  final databaseLoginUserController = TextEditingController();
  final databaseLoginPasswordController = TextEditingController();
  bool _isEdit = false;

  bool get isEdit => _isEdit;

  void setIsEdit(bool isEdit) {
    _isEdit = isEdit;
    notifyListeners();
  }

  Future<bool> save() async {
    if (isValidateControl()) {
      String ipAddress = ipAddressController.text;

      DatabaseHelper().insertBaseUrl(
          {"baseUrl": "http://$ipAddress/WaiterWebService/api/"});

      DatabaseHelper().insertConnector({
        "ipAddress": ipAddressController.text,
        "databaseName": databaseNameController.text,
        "databaseLoginUser": databaseLoginUserController.text,
        "databaseLoginPassword": databaseLoginPasswordController.text
      });

      return true;
    }
    return false;
  }

  bool isValidateControl() {
    if (ipAddressController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterIPAddress);
      return false;
    } else if (databaseNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterDatabaseName);
      return false;
    } else if (databaseLoginUserController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterDatabaseLoginUser);
      return false;
    } else if (databaseLoginPasswordController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterDatabaseLoginPassword);
      return false;
    }
    return true;
  }
}
