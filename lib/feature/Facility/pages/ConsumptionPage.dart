import 'package:flutter/material.dart';
import 'package:ntt/core/route/app_route.dart';
import 'package:ntt/mock/consumption_detail_mock_data.dart';
import 'package:ntt/mock/consumption_mock_data.dart';

import '../../../mock/history_mock_data.dart';

class Consumptionpage extends StatelessWidget {
  final String facilityId;
  const Consumptionpage ({super.key, required this.facilityId});

  @override
  Widget build(BuildContext context) {
    ConsumptionData? currentData;
    final List<ConsumptionData> data = getMockData();
    for(var ConsumptionData in data) {
      if( ConsumptionData.facilityId == facilityId) {
        currentData = ConsumptionData ;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _buildRow("施設名", currentData!.facilityName),
              const SizedBox(height: 4),
              _buildRow("所在地市の情報 :", currentData.cityInfo),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("計測対象時間帯 :",
                    style: TextStyle(
                      color:  Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ), ),
                  SizedBox(width: 20,),
                  Text(currentData!.measurementTimePeriod,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),

              const Divider(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      color: Colors.grey[500],
                      alignment: Alignment.center,
                      child: Text("累計発電電力量",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      color: Colors.grey[700],
                      alignment: Alignment.center,
                      child: Text("${currentData.cumulativePowerGeneration.toStringAsFixed(0)} kWh",
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 70,),


              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 170,
                            decoration: BoxDecoration(
                              color: Colors.grey[500],
                              border: Border.all(color: Colors.black, width: 2)
                            ),
                            alignment: Alignment.center,
                            child: Text("現在の発電電力量\n(KWh)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                          Container(
                            height: 70,
                            width: 170,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: Text("${currentData.formatValue(currentData.currentPowerGeneration)}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.grey[500],
                                border: Border.all(color: Colors.black, width: 2)
                            ),
                            alignment: Alignment.center,
                            child: Text("本日の合計発電電力量\n(KWh)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          Container(
                            height: 70,
                            width: 170,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: Text("${currentData.formatValue(currentData.todayTotalGeneration)}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                        ],
                      )
                    ],

                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.grey[500],
                                border: Border.all(color: Colors.black, width: 2)
                            ),
                            alignment: Alignment.center,
                            child: Text("現在の自家消費量",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          Container(
                            height: 70,
                            width: 170,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: Text("${currentData.formatValue(currentData.currentSelfConsumption)}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.grey[500],
                                border: Border.all(color: Colors.black, width: 2)
                            ),
                            alignment: Alignment.center,
                            child: Text("本日の合計自家消費量",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          Container(
                            height: 70,
                            width: 170,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: Text("${currentData.formatValue(currentData.todayTotalSelfConsumption)}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                        ],
                      )
                    ],

                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.grey[500],
                                border: Border.all(color: Colors.black, width: 2)
                            ),
                            alignment: Alignment.center,
                            child: Text("現在の使用電力量\n(KWh)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          Container(
                            height: 70,
                            width: 170,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: Text("${currentData.formatValue(currentData.currentPowerUsage)}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.grey[500],
                                border: Border.all(color: Colors.black, width: 2)
                            ),
                            alignment: Alignment.center,
                            child: Text("本日の合計使用電力量\n(KWh)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          Container(
                            height: 70,
                            width: 170,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: Text("${currentData.formatValue(currentData.todayTotalPowerUsage)}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                        ],
                      )
                    ],

                  )
                ],
              ),


              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 30,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRoute.search);
                    },
                    child: const Text("施設検索"),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      final List<PowerHistoryData> historyData = getMockHistoryData();
                      Navigator.pushNamed(context, AppRoute.history, arguments: historyData);
                      // Navigator.pushReplacementNamed(context, AppRoute.history, arguments: data);

                    },
                    child: const Text("電力量履歴確認"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(label,
          style: const  TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 17
          ),),
          SizedBox(width: 20,),
          Text(value,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              )),
        ],
      ),
    );
  }
}