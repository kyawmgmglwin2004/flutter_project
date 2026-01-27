import '../../../mock/history_mock_data.dart';

class HistoryService {

  Future<List<PowerHistoryData>> getHourlyData (int year, int month, int day) async {
    await Future.delayed(const Duration(seconds: 1));
    print("reach=================================${PowerHistoryData}");
    return getMockHourlyData(year, month, day);
  }


  Future<List<PowerHistoryData>> getDailyData(int year, int month) async {
    await Future.delayed(const Duration(seconds: 1));
    return getMockDailyData(year, month);
  }


  Future<List<PowerHistoryData>> getMonthlyData(int year, int startMonth , int endMonth ) async {
    await Future.delayed(const Duration(seconds: 1));
    return getMockMonthlyData(year, startMonth, endMonth);
  }
}