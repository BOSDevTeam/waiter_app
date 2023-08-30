import 'package:flutter/material.dart';

class TasteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _lstTaste = [];
  String _selectedTaste = "";
  final tasteController = TextEditingController();

  String get selectedTaste => _selectedTaste;

  List<Map<String, dynamic>> get lstTaste => _lstTaste;

  void setSelectedTaste(String taste) {
    _selectedTaste = "$_selectedTaste$taste,";
    tasteController.text = _selectedTaste;
    notifyListeners();
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
