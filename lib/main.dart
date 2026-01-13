// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:ntt/core/route/app_route.dart';
// import 'package:ntt/core/theme/app_theme.dart';
// import 'package:ntt/feature/FacilitySearch/facility_index.dart';
// import 'package:ntt/feature/FacilitySearch/pages/consumption_page.dart';
// import 'package:ntt/feature/FacilitySearch/pages/HistoryPage.dart';
// import 'package:ntt/feature/FacilitySearch/pages/HistoryTestPage.dart';
//
// import 'mock/history_mock_data.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       initialRoute: AppRoute.root,
//       routes: {
//         AppRoute.root : (context) => const Searchpage(),
//         AppRoute.search: (context) => const Searchpage(),
//         // AppRoute.historytest: (context) => const Historypage(),
//         // AppRoute.consumption: (context) => const Consumptionpage(),
//       },
//       onGenerateRoute: (settings) {
//         if(settings.name == AppRoute.history) {
//           final args = settings.arguments as List<PowerHistoryData>;
//           return MaterialPageRoute(builder: (_) => Historypage(data: args));
//
//         }else if(settings.name == AppRoute.consumption) {
//           final args = settings.arguments as String;
//           return MaterialPageRoute(builder: (_) => Consumptionpage(facilityId : args));
//         }
//       },
//       theme: AppTheme.lightTheme,
//
//        );
//   }
// }

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ntt/core/route/app_route.dart';
import 'package:ntt/core/theme/app_theme.dart';
import 'package:ntt/feature/FacilitySearch/facility_index.dart';
import 'package:ntt/feature/FacilitySearch/pages/ConsumptionPage.dart';
import 'package:ntt/feature/FacilitySearch/pages/HistoryPage.dart';
import 'package:ntt/feature/FacilitySearch/pages/HistoryTestPage.dart';

import 'mock/history_mock_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Energy Management System',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.root,
      routes: {
        AppRoute.root: (context) => const Searchpage(),
        AppRoute.search: (context) => const Searchpage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoute.history) {
          // Handle history route with arguments
          final args = settings.arguments;

          if (args is Map<String, dynamic>) {
            // New way: Map with facility info
            final facilityName = args['facilityName'] ?? 'Unknown FacilitySearch';
            final facilityId = args['facilityId'] ?? 'F001';

            return MaterialPageRoute(
              builder: (_) => HistoryPage(
                facilityName: facilityName,
                facilityId: facilityId,
                initialHourlyData: getMockHourlyData(),
                initialDailyData: getMockDailyData(),
                initialMonthlyData: getMockMonthlyData(),
              ),
            );
          } else if (args is List<PowerHistoryData>) {
            // Old way: Just data list (for backward compatibility)
            return MaterialPageRoute(
              builder: (_) => HistoryPage(
                facilityName: 'Power history',
                facilityId: 'HIST001',
                initialHourlyData: args, // Use the passed data
                initialDailyData: getMockDailyData(),
                initialMonthlyData: getMockMonthlyData(),
              ),
            );
          } else {
            // Default if no arguments
            return MaterialPageRoute(
              builder: (_) => HistoryPage(
                facilityName: 'Demo FacilitySearch',
                facilityId: 'DEMO001',
                initialHourlyData: getMockHourlyData(),
                initialDailyData: getMockDailyData(),
                initialMonthlyData: getMockMonthlyData(),
              ),
            );
          }
        } else if (settings.name == AppRoute.consumption) {
          final args = settings.arguments;
          final facilityId = args is String ? args : 'F001';

          return MaterialPageRoute(
            builder: (_) => Consumptionpage(facilityId: facilityId),
          );
        }

        // Return null for unknown routes
        return null;
      },
      theme: AppTheme.lightTheme,
    );
  }
}