import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../value/app_string.dart';

class RegisterController {
  final macAddressController = TextEditingController();
  final keyController = TextEditingController();

  bool isValidateControl() {
    if (keyController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterKey);
      return false;
    }
    return true;
  }
}
