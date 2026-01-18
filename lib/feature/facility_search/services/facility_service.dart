import 'package:ntt/mock/consumption_detail_mock_data.dart';
import 'package:ntt/mock/consumption_mock_data.dart';

class FacilityService {
  Future<ConsumptionData?> findFacilityById(String id) async {
    final List<ConsumptionData> data = getMockData();

    try {
      return data.firstWhere(
          (item) => item.facilityId == id,
      );
    }catch (e) {
      return null;
    }
  }
}