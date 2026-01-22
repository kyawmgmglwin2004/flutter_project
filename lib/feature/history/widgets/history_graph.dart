// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../mock/history_mock_data.dart';
// import '../controllers/history_controller.dart';
//
// Widget buildGraphArea(BuildContext context) {
//   final provider = context.watch<HistoryProvider>();
//
//   if (provider.currentData.isEmpty) {
//     return const Center(
//       child: Text('No data available'),
//     );
//   }
//
//   final maxY = provider.getMaxValue() * 1.2;
//   final interval = 10000.0;
//
//   return Column(
//     children: [
//       const SizedBox(height: 16),
//       Expanded(
//         child: Stack(
//           children: [
//             Positioned(
//               left: 8,
//               top: 0,
//               bottom: 40,
//               child: Container(
//                 width: 40,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate((maxY / interval).ceil() + 1, (index) {
//                     final value = interval * ((maxY / interval).ceil() - index);
//                     return Text(
//                       value.toInt().toString(),
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 50,
//               top: 0,
//               right: 0,
//               bottom: 0,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: SizedBox(
//                   width: provider.currentData.length * 60.0,
//                   height: 200,
//                   child: BarChart(
//                     BarChartData(
//                       alignment: BarChartAlignment.spaceAround,
//                       maxY: maxY,
//                       minY: 0,
//
//                       barTouchData: BarTouchData(
//                         enabled: true,
//                         touchCallback: (event, response) {
//                           if (response != null &&
//                               response.spot != null &&
//                               event.isInterestedForInteractions) {
//                             context
//                                 .read<HistoryProvider>()
//                                 .selectBar(response.spot!.touchedBarGroupIndex);
//                           }
//                         },
//
//                         touchTooltipData: BarTouchTooltipData(
//                           tooltipPadding: const EdgeInsets.all(8),
//                           tooltipMargin: 8,
//                           getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                             final item = provider.currentData[group.x.toInt()];
//
//                             String label;
//                             double value;
//
//                             if (rodIndex == 0) {
//                               label = 'Generated';
//                               value = item.generatedEnergy;
//                             } else if (rodIndex == 1) {
//                               label = 'Home Cons.';
//                               value = item.selfConsumption;
//                             } else {
//                               label = 'Usage';
//                               value = item.powerUsage;
//                             }
//
//                             return BarTooltipItem(
//                               '$label: ${value.toStringAsFixed(1)} kWh\n${item.label}',
//                               const TextStyle(color: Colors.white),
//                             );
//                           },
//                         ),
//                       ),
//
//                       titlesData: FlTitlesData(
//                         bottomTitles: AxisTitles(
//                           sideTitles: SideTitles(
//                             showTitles: true,
//                             getTitlesWidget: (value, meta) {
//                               final index = value.toInt();
//                               if (index < 0 || index >= provider.currentData.length) {
//                                 return const SizedBox();
//                               }
//
//                               return Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: Text(
//                                   provider.currentData[index].label,
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               );
//                             },
//                             reservedSize: 200,
//                           ),
//                         ),
//                         // Hide left titles since we have fixed y-axis outside
//                         leftTitles: const AxisTitles(
//                           sideTitles: SideTitles(showTitles: false),
//                         ),
//                         topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                         rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                       ),
//
//                       gridData: FlGridData(
//                         show: true,
//                         drawVerticalLine: false,
//                         horizontalInterval: interval,
//                         getDrawingHorizontalLine: (value) {
//                           return FlLine(
//                             color: provider.selectedDisplayType == DisplayType.hourly
//                                 ? Colors.green
//                                 : provider.selectedDisplayType == DisplayType.daily
//                                 ? Colors.red
//                                 : Colors.blue,
//                             strokeWidth: 1,
//                             dashArray: null,
//                           );
//                         },
//                       ),
//
//                       borderData: FlBorderData(
//                         show: true,
//                         border: Border.all(
//                           color: provider.selectedDisplayType == DisplayType.hourly
//                               ? Colors.green
//                               : provider.selectedDisplayType == DisplayType.daily
//                               ? Colors.red
//                               : Colors.blue,
//                         ),
//                       ),
//
//                       barGroups: _buildBarGroups(provider),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
//
// List<BarChartGroupData> _buildBarGroups(HistoryProvider provider) {
//   return List.generate(provider.currentData.length, (index) {
//     final item = provider.currentData[index];
//
//     return BarChartGroupData(
//       x: index,
//       barRods: [
//         BarChartRodData(
//           toY: item.generatedEnergy,
//           width: 11,
//           color: Colors.green,
//           borderRadius: BorderRadius.circular(1),
//         ),
//         BarChartRodData(
//           toY: item.selfConsumption,
//           width: 11,
//           color: Colors.orange[800],
//           borderRadius: BorderRadius.circular(1),
//         ),
//         BarChartRodData(
//           toY: item.powerUsage,
//           width: 11,
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(1),
//         ),
//       ],
//     );
//   });
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mock/history_mock_data.dart';
import '../controllers/history_controller.dart';

Widget buildGraphArea(BuildContext context) {
  final provider = context.watch<HistoryProvider>();

  if (provider.currentData.isEmpty) {
    return const Center(child: Text('No data available'));
  }

  final maxY = provider.getMaxValue() * 1.5;
  const chartHeight = 350.0;
  const yAxisWidth = 45.0;

  return Column(
    children: [
      const SizedBox(height: 100),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('(kWh)', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10
                ),),
                Row(
                  children: [
                   Row(
                     children: [
                       Container(
                         height: 9,
                         width: 9,
                         color: Colors.green,
                       ),
                       SizedBox(width: 3,),
                       Text("発電電力量", style: TextStyle(
                         color: Colors.green,
                         fontSize: 10
                       ),)
                     ],
                   ),
                    SizedBox(width: 7,),
                    Row(
                      children: [
                        Container(
                          height: 9,
                          width: 9,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 3,),
                        Text("自家消費量", style: TextStyle(
                            color: Colors.orange,
                            fontSize: 10
                        ),)
                      ],
                    ),
                    SizedBox(width: 7,),
                    Row(
                      children: [
                        Container(
                          height: 9,
                          width: 9,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 3,),
                        Text("使用電力量", style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10
                        ),)
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
            children: [
              SizedBox(
                width: yAxisWidth,
                height: chartHeight,
                child: BarChart(
                  BarChartData(
                    minY: 0,
                    maxY: maxY,
                    barGroups: const [],
                    gridData: FlGridData(
                      drawVerticalLine: false,
                      horizontalInterval: 10000,
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 10000,
                          reservedSize: 45,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                  ),
                ),
              ),


              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: provider.currentData.length * 60,
                    height: chartHeight,
                    child: BarChart(
                      BarChartData(
                        minY: 0,
                        maxY: maxY,
                        alignment: BarChartAlignment.spaceAround,

                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            tooltipPadding: const EdgeInsets.all(8),
                            tooltipMargin: 8,
                            getTooltipItem:
                                (group, groupIndex, rod, rodIndex) {
                              final item =
                              provider.currentData[group.x.toInt()];

                              late String label;
                              late double value;

                              if (rodIndex == 0) {
                                label = 'Generated';
                                value = item.generatedEnergy;
                              } else if (rodIndex == 1) {
                                label = 'Home Cons.';
                                value = item.selfConsumption;
                              } else {
                                label = 'Usage';
                                value = item.powerUsage;
                              }

                              return BarTooltipItem(
                                '$label: ${value.toStringAsFixed(1)} kWh\n${item.label}',
                                const TextStyle(color: Colors.white),
                              );
                            },
                          ),
                        ),

                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index < 0 ||
                                    index >= provider.currentData.length) {
                                  return const SizedBox();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    provider.currentData[index].label,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),

                        gridData: FlGridData(
                          drawVerticalLine: false,
                          horizontalInterval: 10000,
                        ),

                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: provider.selectedDisplayType ==
                                DisplayType.hourly
                                ? Colors.green
                                : provider.selectedDisplayType ==
                                DisplayType.daily
                                ? Colors.red
                                : Colors.blue,
                          ),
                        ),

                        barGroups: _buildBarGroups(provider),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ]
        ),
      ),
    ],
  );
}
List<BarChartGroupData> _buildBarGroups(HistoryProvider provider) {
  return List.generate(provider.currentData.length, (index) {
    final item = provider.currentData[index];

    return BarChartGroupData(
      x: index,
      barsSpace: 3,
      barRods: [
        BarChartRodData(
          toY: item.generatedEnergy,
          width: 6,
          color: Colors.green,
          borderRadius: BorderRadius.circular(2),
        ),
        BarChartRodData(
          toY: item.selfConsumption,
          width: 6,
          color: Colors.orange,
          borderRadius: BorderRadius.circular(2),
        ),
        BarChartRodData(
          toY: item.powerUsage,
          width: 6,
          color: Colors.blue,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  });
}
