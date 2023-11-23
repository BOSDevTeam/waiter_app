import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../value/app_string.dart';

class PasswordProvider extends ChangeNotifier {
  final passwordController = TextEditingController();

  bool isValidateControl() {
    if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterPassword);
      return false;
    }
    return true;
  }

}
