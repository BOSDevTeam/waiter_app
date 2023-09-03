import 'package:flutter/material.dart';

class TasteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _lstTaste = [];
  String _selectedTaste = "";
  final tasteController = TextEditingController();

  String get selectedTaste => _selectedTaste;

  List<Map<String, dynamic>> get lstTaste => _lstTaste;

  void setSelectedTaste(String taste) {
    if (taste.isNotEmpty) {
      if (_selectedTaste.isNotEmpty) {
        _selectedTaste = "$_selectedTaste,$taste";
      } else {
        _selectedTaste = taste;
      }
      tasteController.text = _selectedTaste;
      notifyListeners();
    }
  }

  void loadSelectedTaste(String taste) {
    if (taste.isNotEmpty) {
      if (_selectedTaste.isNotEmpty) {
        _selectedTaste = "$_selectedTaste,$taste";
      } else {
        _selectedTaste = taste;
      }
      tasteController.text = _selectedTaste;
    }
  }

  void clearSelectedTaste() {
    _selectedTaste = "";
    tasteController.text = "";
    notifyListeners();
  }

  void setTaste(List<Map<String, dynamic>> lstTaste) {
    _lstTaste = lstTaste;
    notifyListeners();
  }

}
