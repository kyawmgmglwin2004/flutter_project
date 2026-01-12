import 'package:flutter/material.dart';

class Historytestpage extends StatefulWidget {
  const Historytestpage({super.key});

  @override
  State<Historytestpage> createState() => _HistorytestpageState();
}

class _HistorytestpageState extends State<Historytestpage> {

  String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Facility Name_",
                      style:TextStyle(
                        color: Colors.blue[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),),
                      Text("電力量履歴",
                      style: TextStyle(
                        color: Colors.blue[500]
                      ),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Text("Display type",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      RadioListTile<String>(
                        value: "Day",
                        groupValue: _selectedValue,
                        title: const Text(
                          "Day (နေ့)",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        activeColor: Colors.red,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),

                      Container(
                        height: 30,
                        width: 200,

                        child: RadioListTile<String>(
                          value: "Month",
                          groupValue: _selectedValue,
                          title: const Text(
                            "Month (လ)",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                          activeColor: Colors.red,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ) ,
            )),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:ntt/core/route/app_route.dart';
// import 'package:ntt/mock/history_mock_data.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class Historypage extends StatelessWidget {
//   final String facilityId;
//
//   const Historypage({super.key, required this.facilityId});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<PowerHistoryData> graphData = getHistoryMockData(facilityId);
//
//     return Scaffold(
//       appBar: AppBar(title: Text("History: $facilityId")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const Text("Power Consumption History", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//
//             AspectRatio(
//               aspectRatio: 1.5,
//               child: BarChart(
//                 BarChartData(
//                   alignment: BarChartAlignment.spaceAround,
//                   maxY: 2.0,
//                   titlesData: FlTitlesData(
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           final index = value.toInt();
//                           if (index >= 0 && index < graphData.length) {
//                             return Text(graphData[index].label, style: const TextStyle(fontSize: 10));
//                           }
//                           return const Text('');
//                         },
//                       ),
//                     ),
//                     leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   ),
//                   borderData: FlBorderData(show: false),
//                   barGroups: graphData.asMap().entries.map((entry) {
//                     return BarChartGroupData(
//                       x: entry.key,
//                       barRods: [
//                         BarChartRodData(toY: entry.value.generatedEnergy, color: Colors.green, width: 8),
//                         BarChartRodData(toY: entry.value.selfConsumption, color: Colors.orange, width: 8),
//                         BarChartRodData(toY: entry.value.powerUsage, color: Colors.blue, width: 8),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
