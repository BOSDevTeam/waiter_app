import 'package:flutter/material.dart';

class TasteProvider extends ChangeNotifier{
   List<Map<String, dynamic>> lstTaste = [];
   String _selectedTaste="";
   final tasteController=TextEditingController();

   String get selectedTaste=>_selectedTaste;

   void setSelectedTaste(String taste){
    _selectedTaste="$_selectedTaste$taste,";
    tasteController.text=_selectedTaste;
    notifyListeners();
   }
}