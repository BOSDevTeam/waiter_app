import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../value/app_string.dart';

class TimeProvider extends ChangeNotifier {
  String _period = "";
  bool _isAMSelected = false;
  bool _isPMSelected = false;
  final hourController = TextEditingController();
  final minuteController = TextEditingController();

  String get period => _period;
  bool get isAMSelected => _isAMSelected;
  bool get isPMSelected => _isPMSelected;

  void setHour(String hour) {
    hourController.text = hour;
  }

  void setMinute(String minute) {
    minuteController.text = minute;
  }

  void setSelectedPeriod(String period, bool isNotify) {
    _period = period;
    _isAMSelected = false;
    _isPMSelected = false;
    if (period == "AM") {
      _isAMSelected = true;
    } else if (period == "PM") {
      _isPMSelected = true;
    }
    if (isNotify) notifyListeners();
  }

  bool validateControl() {
    if (hourController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterHour);
      return false;
    } else if (int.parse(hourController.text) > 12) {
      Fluttertoast.showToast(msg: AppString.invalidHour);
      return false;
    } else if (minuteController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterMinute);
      return false;
    } else if (int.parse(minuteController.text) > 60) {
      Fluttertoast.showToast(msg: AppString.invalidMinute);
      return false;
    }
    return true;
  }
}
