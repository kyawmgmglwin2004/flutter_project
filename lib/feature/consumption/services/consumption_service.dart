
import 'package:ntt/mock/consumption_detail_mock_data.dart';
import 'package:ntt/mock/consumption_mock_data.dart';

class ConsumptionService {
  ConsumptionData? getByFacilityId(String facilityId) {
    final data = getMockData();

    try {
      return data.firstWhere(
            (item) => item.facilityId == facilityId,
      );
    } catch (e) {
      return null;
    }
  }
}
