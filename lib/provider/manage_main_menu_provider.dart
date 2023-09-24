import 'package:flutter/material.dart';

class ManageMainMenuProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _lstMainMenu = [];

  List<Map<String, dynamic>> get lstMainMenu => _lstMainMenu;

  void setMainMenu(List<Map<String, dynamic>> lstMainMenu) {
    _lstMainMenu = lstMainMenu;
    notifyListeners();
  }

  void updateOpenClose(int index, Map<String, dynamic> mainMenu) {
    _lstMainMenu.removeAt(index);
    _lstMainMenu[index] = mainMenu;
    notifyListeners();
  }
}
