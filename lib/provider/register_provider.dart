import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../value/app_string.dart';

class RegisterProvider extends ChangeNotifier {
  final macAddressController = TextEditingController();
  final keyController = TextEditingController();
  String key = "";

  bool isValidateKey() {
    if (keyController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterKey);
      return false;
    } else if (key != keyController.text) {
      Fluttertoast.showToast(msg: AppString.invalidKey);
      return false;
    }
    return true;
  }
}
