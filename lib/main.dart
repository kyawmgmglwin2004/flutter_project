import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ntt/core/route/app_route.dart';
import 'package:ntt/core/theme/app_theme.dart';
import 'package:ntt/feature/history/history_index.dart';
import 'package:ntt/feature/consumption/consumption_index.dart';
import 'package:ntt/feature/facility_search/pages/facility_search.dart';

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
        AppRoute.root: (context) => const FacilitySearch(),
        AppRoute.search: (context) => const FacilitySearch(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoute.history) {
          final args = settings.arguments;

          if (args is Map<String, dynamic>) {
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