// import 'package:flutter/material.dart';
// import 'package:ntt/core/route/app_route.dart';
// import 'package:ntt/mock/consumption_detail_mock_data.dart';
// import 'package:ntt/mock/consumption_mock_data.dart';
//
// import '../../../mock/history_mock_data.dart';
//
// class Consumptionpage extends StatelessWidget {
//   final String facilityId;
//   const Consumptionpage({super.key, required this.facilityId});
//
//   @override
//   Widget build(BuildContext context) {
//     ConsumptionData? currentData;
//     final List<ConsumptionData> data = getMockData();
//
//     for (var item in data) {
//       if (item.facilityId == facilityId) {
//         print("reach consumption page");
//         currentData = item;
//       }
//     }
//
//     return Scaffold(
//       key: const Key('consumption_screen'),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildRow("施設名", currentData!.facilityName),
//               _buildRow("所在地市の情報 :", currentData.cityInfo),
//
//               _measurementTimePeriod(currentData),
//
//               const Divider(height: 32),
//
//               _cumulativePowerGeneration(currentData),
//
//               const SizedBox(height: 40),
//
//               _twoColumnRow(
//                 leftTitle: "現在の発電電力量",
//                 leftValue: currentData.formatValue(
//                   currentData.currentPowerGeneration,
//                 ),
//                 rightTitle: "本日の合計発電電力量",
//                 rightValue: currentData.formatValue(
//                   currentData.todayTotalGeneration,
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               _twoColumnRow(
//                 leftTitle: "現在の自家消費量",
//                 leftValue: currentData.formatValue(
//                   currentData.currentSelfConsumption,
//                 ),
//                 rightTitle: "本日の合計自家消費量",
//                 rightValue: currentData.formatValue(
//                   currentData.todayTotalSelfConsumption,
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               _twoColumnRow(
//                 leftTitle: "現在の使用電力量",
//                 leftValue: currentData.formatValue(
//                   currentData.currentPowerUsage,
//                 ),
//                 rightTitle: "本日の合計使用電力量",
//                 rightValue: currentData.formatValue(
//                   currentData.todayTotalPowerUsage,
//                 ),
//               ),
//
//               const SizedBox(height: 32),
//
//               Row(
//                 children: [
//                   _searchPageButton(context),
//                   const SizedBox(width: 16),
//                   _historyPageButton(context),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               color: Colors.blue,
//               fontWeight: FontWeight.bold,
//               fontSize: 17,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 color: Colors.blue,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _measurementTimePeriod(dynamic currentData) {
//     return Row(
//       children: [
//         Text(
//           "計測対象時間帯 :",
//           style: TextStyle(
//             color: Colors.blue,
//             fontWeight: FontWeight.bold,
//             fontSize: 17,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(
//             currentData.measurementTimePeriod,
//             style: const TextStyle(
//               color: Colors.red,
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _twoColumnRow({
//     required String leftTitle,
//     required String leftValue,
//     required String rightTitle,
//     required String rightValue,
//   }) {
//     return Row(
//       children: [
//         Expanded(
//           child: _infoBox(title: leftTitle, value: leftValue),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: _infoBox(title: rightTitle, value: rightValue),
//         ),
//       ],
//     );
//   }
//
//   Widget _cumulativePowerGeneration(dynamic currentData) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: 40,
//             alignment: Alignment.center,
//             color: Colors.grey[500],
//             child: const Text(
//               "累計発電電力量",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             height: 40,
//             alignment: Alignment.center,
//             color: Colors.grey[700],
//             child: Text(
//               "${currentData.cumulativePowerGeneration.toStringAsFixed(0)} kWh",
//               style: const TextStyle(
//                 color: Colors.cyanAccent,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _searchPageButton(BuildContext context) {
//     return Expanded(
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.orange,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         onPressed: () {
//           Navigator.pushReplacementNamed(context, AppRoute.search);
//         },
//         child: const Text("施設検索"),
//       ),
//     );
//   }
//
//   Widget _historyPageButton(BuildContext context) {
//     return Expanded(
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.orange,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         onPressed: () {
//           final List<PowerHistoryData> historyData = getMockHistoryData();
//           Navigator.pushNamed(
//             context,
//             AppRoute.history,
//             arguments: historyData,
//           );
//         },
//         child: const Text("電力量履歴確認"),
//       ),
//     );
//   }
//
//   Widget _infoBox({required String title, required String value}) {
//     return Column(
//       children: [
//         Container(
//           height: 60,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: Colors.grey[500],
//             border: Border.all(color: Colors.black, width: 2),
//           ),
//           child: Text(
//             title,
//             textAlign: TextAlign.center,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Container(
//           height: 70,
//           alignment: Alignment.center,
//           color: Colors.grey[100],
//           child: Text(
//             value,
//             style: const TextStyle(
//               color: Colors.red,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ntt/core/route/app_route.dart';
import '../controllers/consumption_controller.dart';
import '../widgets/info_box.dart';
import '../widgets/label_row.dart';
import '../../../mock/history_mock_data.dart';

class ConsumptionPage extends StatelessWidget {
  final String facilityId;
  const ConsumptionPage({super.key, required this.facilityId});

  @override
  Widget build(BuildContext context) {
    final controller = ConsumptionController();
    final data = controller.loadConsumption(facilityId)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelRow(label: "施設名", value: data.facilityName),
              LabelRow(label: "所在地市の情報 :", value: data.cityInfo),
              LabelRow(
                label: "計測対象時間帯 :",
                value: data.measurementTimePeriod,
                valueColor: Colors.red,
              ),

              const Divider(height: 32),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      color: Colors.grey[500],
                      child: const Text(
                        "累計発電電力量",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      color: Colors.grey[700],
                      child: Text(
                        data.formatValue(data.cumulativePowerGeneration),
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              _twoColumn(data, "現在の発電電力量", data.currentPowerGeneration,
                  "本日の合計発電電力量", data.todayTotalGeneration),

              const SizedBox(height: 24),

              _twoColumn(data, "現在の自家消費量", data.currentSelfConsumption,
                  "本日の合計自家消費量", data.todayTotalSelfConsumption),

              const SizedBox(height: 24),

              _twoColumn(data, "現在の使用電力量", data.currentPowerUsage,
                  "本日の合計使用電力量", data.todayTotalPowerUsage),

              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoute.search);
                      },
                      child: const Text("施設検索"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    ),
                    ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.history,
                          arguments: getMockHistoryData(),
                          // arguments: {'facilityId': facilityId}
                        );
                      },
                      child: const Text("電力量履歴確認"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _twoColumn(
      dynamic data,
      String leftTitle,
      double leftValue,
      String rightTitle,
      double rightValue,
      ) {
    return Row(
      children: [
        Expanded(
          child: InfoBox(
            title: leftTitle,
            value: data.formatValue(leftValue),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InfoBox(
            title: rightTitle,
            value: data.formatValue(rightValue),
          ),
        ),
      ],
    );
  }
}

