import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../controllers/history_controller.dart';

class BarChartView extends StatelessWidget {
  final HistoryController controller;

  const BarChartView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: controller.maxValue * 1.2,
        barGroups: controller.data.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          final selected = controller.selectedBarIndex == i;

          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: item.generatedEnergy,
                color: selected ? Colors.green[400]! : Colors.green,
                width: 8,
              ),
              BarChartRodData(
                toY: item.selfConsumption,
                color: selected ? Colors.orange[400]! : Colors.red,
                width: 8,
              ),
              BarChartRodData(
                toY: item.powerUsage,
                color: selected ? Colors.blue[400]! : Colors.blue,
                width: 8,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
