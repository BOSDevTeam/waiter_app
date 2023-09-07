import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier {
  String _hour = "";
  String _minute = "";
  String _period = "";
  bool _isAMSelected = false;
  bool _isPMSelected = false;

  String get hour => _hour;
  String get minute => _minute;
  String get period => _period;
  bool get isAMSelected => _isAMSelected;
  bool get isPMSelected => _isPMSelected;

  void setHour(String hour) {
    _hour = hour;
  }

  void setMinute(String minute) {
    _minute = minute;
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
}
