import 'package:flutter/material.dart';

class DataUpdatingProvider extends ChangeNotifier {
  bool _isWaiterComplete = false;
  bool _isMainMenuComplete = false;
  bool _isSubMenuComplete = false;
  bool _isItemComplete = false;
  bool _isSystemItemComplete = false;
  bool _isTableTypeComplete = false;
  bool _isTableComplete = false;
  bool _isTasteComplete = false;
  bool _isTasteMultiComplete = false;
  bool _isSystemSettingComplete = false;
  bool _isShowLoading = false;

  bool get isWaiterComplete => _isWaiterComplete;
  bool get isMainMenuComplete => _isMainMenuComplete;
  bool get isSubMenuComplete => _isSubMenuComplete;
  bool get isItemComplete => _isItemComplete;
  bool get isSystemItemComplete => _isSystemItemComplete;
  bool get isTableTypeComplete => _isTableTypeComplete;
  bool get isTableComplete => _isTableComplete;
  bool get isTasteComplete => _isTasteComplete;
  bool get isTasteMultiComplete => _isTasteMultiComplete;
  bool get isSystemSettingComplete => _isSystemSettingComplete;
  bool get isShowLoading => _isShowLoading;

  void setIsWaiterComplete(bool result) {
    _isWaiterComplete = result;
    notifyListeners();
  }

  void setIsMainMenuComplete(bool result) {
    _isMainMenuComplete = result;
    notifyListeners();
  }

  void setIsSubMenuComplete(bool result) {
    _isSubMenuComplete = result;
    notifyListeners();
  }

  void setIsItemComplete(bool result) {
    _isItemComplete = result;
    notifyListeners();
  }

  void setIsSystemItemComplete(bool result) {
    _isSystemItemComplete = result;
    notifyListeners();
  }

  void setIsTableTypeComplete(bool result) {
    _isTableTypeComplete = result;
    notifyListeners();
  }

  void setIsTableComplete(bool result) {
    _isTableComplete = result;
    notifyListeners();
  }

  void setIsTasteComplete(bool result) {
    _isTasteComplete = result;
    notifyListeners();
  }

  void setIsTasteMultiComplete(bool result) {
    _isTasteMultiComplete = result;
    notifyListeners();
  }

  void setIsSystemSettingComplete(bool result) {
    _isSystemSettingComplete = result;
    notifyListeners();
  }

  void setIsShowLoading(bool result) {
    _isShowLoading = result;
    notifyListeners();
  }
}
