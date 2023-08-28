import 'package:flutter/material.dart';

class TasteProvider extends ChangeNotifier{
   List<Map<String, dynamic>> lstTaste = [];
   String _selectedTaste="";

   String get selectedTaste=>_selectedTaste;

   void setSelectedTaste(String taste){
    _selectedTaste="$_selectedTaste$taste,";
    notifyListeners();
   }
}