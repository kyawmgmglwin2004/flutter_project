import 'package:flutter/material.dart';
import 'package:ntt/mock/history_mock_data.dart';
import '../services/history_service.dart';

enum DisplayType { hourly, daily, monthly }

class HistoryController extends ChangeNotifier {
  final HistoryService service;

  HistoryController(this.service) {
    loadHourly();
  }

  DisplayType displayType = DisplayType.hourly;
  List<PowerHistoryData> data = [];

  DateTime selectedDate = DateTime.now();
  DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);

  int selectedBarIndex = -1;

  void loadHourly() {
    displayType = DisplayType.hourly;
    data = service.getHourly();
    notifyListeners();
  }

  void loadDaily() {
    displayType = DisplayType.daily;
    data = service.getDaily();
    notifyListeners();
  }

  void loadMonthly() {
    displayType = DisplayType.monthly;
    data = service.getMonthly();
    notifyListeners();
  }

  void selectBar(int index) {
    selectedBarIndex = index;
    notifyListeners();
  }

  double get maxValue {
    if (data.isEmpty) return 50;
    return data
        .expand((e) => [e.generatedEnergy, e.selfConsumption, e.powerUsage])
        .reduce((a, b) => a > b ? a : b);
  }
}
