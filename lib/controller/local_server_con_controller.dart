import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter_app/model/connector_model.dart';

import '../value/app_string.dart';

class LocalServerConController {
  final ipAddressController = TextEditingController();
  final databaseNameController = TextEditingController();
  final databaseLoginUserController = TextEditingController();
  final databaseLoginPasswordController = TextEditingController();

  Future<ConnectorModel> save() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (isValidateControl()) {
      sharedPreferences.setString("IPAddress", ipAddressController.text);
      sharedPreferences.setString("DatabaseName", databaseNameController.text);
      sharedPreferences.setString(
          "DatabaseLoginUser", databaseLoginUserController.text);
      sharedPreferences.setString(
          "DatabaseLoginPassword", databaseLoginPasswordController.text);
    }
    return ConnectorModel(
        ipAddress: sharedPreferences.getString("IPAddress").toString(),
        databaseName: sharedPreferences.getString("DatabaseName").toString(),
        databaseLoginUser:
            sharedPreferences.getString("DatabaseLoginUser").toString(),
        databaseLoginPassword:
            sharedPreferences.getString("DatabaseLoginPassword").toString());
  }

  bool isValidateControl() {
    if (ipAddressController.text.isEmpty) {
      SnackBar(content: Text(AppString.enterIPAddress));
      return false;
    } else if (databaseNameController.text.isEmpty) {
      return false;
    } else if (databaseLoginUserController.text.isEmpty) {
      return false;
    } else if (databaseLoginPasswordController.text.isEmpty) {
      return false;
    }
    return true;
  }
}
