import 'package:flutter/material.dart';
import 'package:waiter_app/model/table_situation_model.dart';

class TableSituationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _lstTableType = [];
  Map<String, dynamic> _selectedTableType = {};
  List<TableSituationModel> _lstTableSituation = [];

  List<Map<String, dynamic>> get lstTableType => _lstTableType;
  Map<String, dynamic> get selectedTableType => _selectedTableType;
  List<TableSituationModel> get lstTableSituation => _lstTableSituation;

  void setTableType(List<Map<String, dynamic>> lstTableType) {
    _lstTableType = lstTableType;
    notifyListeners();
  }

  void setSelectedTableType(Map<String, dynamic> selectedTableType) {
    _selectedTableType = selectedTableType;
    notifyListeners();
  }

  void setTableSituation(List<TableSituationModel> lstTableSituation) {
    _lstTableSituation = lstTableSituation;
    notifyListeners();
  }
}
