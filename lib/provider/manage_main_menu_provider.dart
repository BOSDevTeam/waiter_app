import 'package:flutter/material.dart';

import '../model/main_menu_model.dart';

class ManageMainMenuProvider extends ChangeNotifier {
  List<MainMenuModel> _lstMainMenu = [];

  List<MainMenuModel> get lstMainMenu => _lstMainMenu;

  void setMainMenu(List<MainMenuModel> lstMainMenu) {
    _lstMainMenu = lstMainMenu;
    notifyListeners();
  }

  void updateOpenClose(int index, int result) {
    _lstMainMenu[index].isOpen = result;
    notifyListeners();
  }
}
