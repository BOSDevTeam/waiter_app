import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../hive/hive_db.dart';
import '../value/app_string.dart';

class LocalServerConController {
  final ipAddressController = TextEditingController();
  final databaseNameController = TextEditingController();
  final databaseLoginUserController = TextEditingController();
  final databaseLoginPasswordController = TextEditingController();

  Future<bool> save() async {
    if (isValidateControl()) {
      String ipAddress = ipAddressController.text;

      HiveDB.insertBaseUrl(
          {"baseUrl": "http://$ipAddress/WaiterWebService/api/"});

      HiveDB.insertConnectorBox({
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
