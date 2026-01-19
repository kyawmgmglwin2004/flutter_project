import 'package:flutter/material.dart';
import 'package:ntt/core/route/app_route.dart';
import 'package:ntt/core/theme/app_theme.dart';
import 'package:ntt/feature/history/controllers/history_controller.dart';
import 'package:ntt/feature/history/history_index.dart';
import 'package:ntt/feature/consumption/consumption_index.dart';
import 'package:ntt/feature/facility_search/pages/facility_search.dart';
import 'package:provider/provider.dart';

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
        AppRoute.root: (context) => const FacilitySearchPage(),
        AppRoute.search: (context) => const FacilitySearchPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoute.history) {
          final args = settings.arguments;

          if (args is Map<String, dynamic>) {
            final facilityName =
                args['facilityName'] ?? 'Unknown FacilitySearch';
            final facilityId = args['facilityId'] ?? 'F001';

            return MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => HistoryProvider()..init(),
                child : HistoryPage(
                  facilityName: facilityName,
                  facilityId: facilityId,
                  initialHourlyData: getMockHourlyData(),
                  initialDailyData: getMockDailyData(),
                  initialMonthlyData: getMockMonthlyData(),
                ),
              ),
            );
          } else if (args is List<PowerHistoryData>) {
            // Old way: Just data list (for backward compatibility)
            return MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => HistoryProvider()..init(),
                child: HistoryPage(
                  facilityName: 'Power history',
                  facilityId: 'HIST001',
                  initialHourlyData: args, // Use the passed data
                  initialDailyData: getMockDailyData(),
                  initialMonthlyData: getMockMonthlyData(),
                ),
              ),
            );
          } else {
            // Default if no arguments
            return MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => HistoryProvider()..init(),
                child: HistoryPage(
                  facilityName: 'Demo FacilitySearch',
                  facilityId: 'DEMO001',
                  initialHourlyData: getMockHourlyData(),
                  initialDailyData: getMockDailyData(),
                  initialMonthlyData: getMockMonthlyData(),
                ),
              ),
            );
          }
        } else if (settings.name == AppRoute.consumption) {
          final args = settings.arguments;
          final facilityId = args is String ? args : 'F001';

          return MaterialPageRoute(
            builder: (_) => ConsumptionPage(facilityId: facilityId),
          );
        }

        return null;
      },
      theme: AppTheme.lightTheme,
    );
  }
}
