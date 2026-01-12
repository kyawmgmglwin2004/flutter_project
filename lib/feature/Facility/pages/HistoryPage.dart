import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ntt/mock/history_mock_data.dart';

class Historypage extends StatelessWidget {
  final List<PowerHistoryData> data;

  const Historypage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        _buildLegend(),

        // 2. Graph Area - Screen Item #10
        AspectRatio(
          aspectRatio: 1.7,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: _getMaxValue() * 1.2,
              barTouchData: BarTouchData(
                enabled: true,

                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (group) => Colors.grey[800]!,
                  tooltipPadding: const EdgeInsets.all(8),
                  tooltipMargin: 8,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String label;
                    double value;
                    Color color;

                    if (rodIndex == 0) {
                      label = 'Generated';
                      value = data[group.x.toInt()].generatedEnergy;
                      color = Colors.green;
                    } else if (rodIndex == 1) {
                      label = 'Self Cons.';
                      value = data[group.x.toInt()].selfConsumption;
                      color = Colors.orange;
                    } else {
                      label = 'Usage';
                      value = data[group.x.toInt()].powerUsage;
                      color = Colors.blue;
                    }
                    return BarTooltipItem(
                      '$label\n${value.toStringAsFixed(2)} kWh',
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // X-axis မှာ Label များပြသခြင်း (Item 16, 17)
                      final index = value.toInt();
                      if (index >= 0 && index < data.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            data[index].label,
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        );
                      }
                      return const Text('');
                    },
                    reservedSize: 30,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false), // Y-axis numbers ဖျော့ထားတာ
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(show: false), // Grid lines ဖျော့ထားတာ (Clean UI)
              borderData: FlBorderData(show: false),
              barGroups: _buildBarGroups(),
            ),
          ),
        ),
      ],
    );
  }

  // Bar Groups တွေကို ဖန်တီးခြင်း
  List<BarChartGroupData> _buildBarGroups() {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      PowerHistoryData item = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [

          BarChartRodData(
            toY: item.generatedEnergy,
            color: Colors.green,
            width: 8,
            borderRadius: BorderRadius.circular(2),
          ),
          // Bar 2: Home consumption (Orange) - Item 19
          BarChartRodData(
            toY: item.selfConsumption,
            color: Colors.orange,
            width: 8,
            borderRadius: BorderRadius.circular(2),
          ),
          // Bar 3: Electricity consumption (Blue) - Item 20
          BarChartRodData(
            toY: item.powerUsage,
            color: Colors.blue,
            width: 8,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      );
    }).toList();
  }


  double _getMaxValue() {
    if(data.isEmpty) return 5.0;
    double max = 0;
    for (var item in data) {
      if (item.powerUsage > max) max = item.powerUsage;
      if (item.generatedEnergy > max) max = item.generatedEnergy;
      if (item.selfConsumption > max) max = item.selfConsumption;
    }
    return max;
  }


  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _legendItem(Colors.green, "Generated"),
          SizedBox(width: 16),
          _legendItem(Colors.orange, "Home Cons."),
          SizedBox(width: 16),
          _legendItem(Colors.blue, "Usage"),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color,),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}