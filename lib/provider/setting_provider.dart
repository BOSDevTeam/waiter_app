import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../value/app_setting.dart';

class SettingProvider extends ChangeNotifier {
  bool? _addTimeByItemInOrder = false;
  bool? _showTasteInSelectItem = false;
  bool? _useTasteByMenu = false;
  bool? _notPutItemAndTasteInOrder = false;
  bool? _addStartTimeInOrder = false;
  bool? _hideSalePriceInItem = false;
  bool? _hideCommercialTax = false;
  bool? _calculateAdvancedTax = false;
  bool? _addCustomerByTotalPerson = false;

  bool? get addTimeByItemInOrder => _addTimeByItemInOrder;
  bool? get showTasteInSelectItem => _showTasteInSelectItem;
  bool? get useTasteByMenu => _useTasteByMenu;
  bool? get notPutItemAndTasteInOrder => _notPutItemAndTasteInOrder;
  bool? get addStartTimeInOrder => _addStartTimeInOrder;
  bool? get hideSalePriceInItem => _hideSalePriceInItem;
  bool? get hideCommercialTax => _hideCommercialTax;
  bool? get calculateAdvancedTax => _calculateAdvancedTax;
  bool? get addCustomerByTotalPerson => _addCustomerByTotalPerson;

  Future<void> fillGeneralSetting() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _addTimeByItemInOrder =
        sharedPreferences.getBool(AppSetting.addTimeByItemInOrder);
    _showTasteInSelectItem =
        sharedPreferences.getBool(AppSetting.showTasteInSelectItem);
    _useTasteByMenu = sharedPreferences.getBool(AppSetting.useTasteByMenu);
    _notPutItemAndTasteInOrder =
        sharedPreferences.getBool(AppSetting.notPutItemAndTasteInOrder);
    _addStartTimeInOrder =
        sharedPreferences.getBool(AppSetting.addStartTimeInOrder);
    _hideSalePriceInItem =
        sharedPreferences.getBool(AppSetting.hideSalePriceInItem);
    _hideCommercialTax =
        sharedPreferences.getBool(AppSetting.hideCommercialTax);
    _calculateAdvancedTax =
        sharedPreferences.getBool(AppSetting.calculateAdvancedTax);
    _addCustomerByTotalPerson =
        sharedPreferences.getBool(AppSetting.addCustomerByTotalPerson);
    notifyListeners();
  }

  Future<bool?> getShowTasteInSelectItem() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(AppSetting.showTasteInSelectItem);
  }

  Future<bool?> getUseTasteByMenu() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(AppSetting.useTasteByMenu);
  }

  Future<bool?> getHideSalePriceInItem() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(AppSetting.hideSalePriceInItem);
  }

  Future<bool?> getAddStartTimeInOrder() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(AppSetting.addStartTimeInOrder);
  }

  Future<bool?> getAddTimeByItemInOrder() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(AppSetting.addTimeByItemInOrder);
  }

  Future<bool?> getNotPutItemAndTasteInOrder() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(AppSetting.notPutItemAndTasteInOrder);
  }

  Future<void> setAddTimeByItemInOrder(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppSetting.addTimeByItemInOrder, value);
    _addTimeByItemInOrder = value;
    notifyListeners();
  }

  Future<void> setShowTasteInSelectItem(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppSetting.showTasteInSelectItem, value);
    _showTasteInSelectItem = value;
    notifyListeners();
  }

  Future<void> setUseTasteByMenu(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppSetting.useTasteByMenu, value);
    _useTasteByMenu = value;
    notifyListeners();
  }

  Future<void> setNotPutItemAndTasteInOrder(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppSetting.notPutItemAndTasteInOrder, value);
    _notPutItemAndTasteInOrder = value;
    notifyListeners();
  }

  Future<void> setAddStartTimeInOrder(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppSetting.addStartTimeInOrder, value);
    _addStartTimeInOrder = value;
    notifyListeners();
  }

  Future<void> setHideSalePriceInItem(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppSetting.hideSalePriceInItem, value);
    _hideSalePriceInItem = value;
    notifyListeners();
  }

  Future<void> setHideCommercialTax(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppSetting.hideCommercialTax, value);
    _hideCommercialTax = value;
    notifyListeners();
  }

  Future<void> setCalculateAdvancedTax(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppSetting.calculateAdvancedTax, value);
    _calculateAdvancedTax = value;
    notifyListeners();
  }

  Future<void> setAddCustomerByTotalPerson(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppSetting.addCustomerByTotalPerson, value);
    _addCustomerByTotalPerson = value;
    notifyListeners();
  }
}
