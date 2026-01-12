import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ntt/core/route/app_route.dart';
import 'package:ntt/core/theme/app_theme.dart';
import 'package:ntt/feature/Facility/facility_index.dart';
import 'package:ntt/feature/Facility/pages/ConsumptionPage.dart';
import 'package:ntt/feature/Facility/pages/HistoryPage.dart';
import 'package:ntt/feature/Facility/pages/HistoryTestPage.dart';

import 'mock/history_mock_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.root,
      routes: {
        AppRoute.root : (context) => const Searchpage(),
        AppRoute.search: (context) => const Searchpage(),
        AppRoute.historytest: (context) => const Historytestpage(),
        // AppRoute.consumption: (context) => const Consumptionpage(),
      },
      onGenerateRoute: (settings) {
        if(settings.name == AppRoute.history) {
          final args = settings.arguments as List<PowerHistoryData>;
          return MaterialPageRoute(builder: (_) => Historypage(data: args));

        }else if(settings.name == AppRoute.consumption) {
          final args = settings.arguments as String;
          return MaterialPageRoute(builder: (_) => Consumptionpage(facilityId : args));
        }
      },
      theme: AppTheme.lightTheme,

       );
  }
}
