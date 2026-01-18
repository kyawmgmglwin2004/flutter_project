import 'package:ntt/mock/history_mock_data.dart';

class HistoryService {
  List<PowerHistoryData> getHourly() => getMockHistoryData();
  List<PowerHistoryData> getDaily() => getMockHistoryData();
  List<PowerHistoryData> getMonthly() => getMockHistoryData();
}
