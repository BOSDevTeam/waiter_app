import 'package:flutter/material.dart';

class TasteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _lstTaste = [];
  String _selectedTaste = "";
  int _selectedTastePrice = 0;
  final tasteController = TextEditingController();

  String get selectedTaste => _selectedTaste;
  int get selectedTastePrice => _selectedTastePrice;

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

  void setSelectedTastePrice(int tastePrice) {
    _selectedTastePrice += tastePrice;
  }

  void loadSelectedTaste(String taste, int totalTastePrice) {
    if (taste.isNotEmpty) {
      if (_selectedTaste.isNotEmpty) {
        _selectedTaste = "$_selectedTaste,$taste";
      } else {
        _selectedTaste = taste;
      }
      tasteController.text = _selectedTaste;
      _selectedTastePrice = totalTastePrice;
    }
  }

  void clearSelectedTaste() {
    _selectedTaste = "";
    tasteController.text = "";
    notifyListeners();
  }

  void clearSelectedTastePrice() {
    _selectedTastePrice = 0;
  }

  void setTaste(List<Map<String, dynamic>> lstTaste) {
    _lstTaste = lstTaste;
    notifyListeners();
  }
}
