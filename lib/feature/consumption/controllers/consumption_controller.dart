
import '../../../mock/consumption_mock_data.dart';
import '../services/consumption_service.dart';

class ConsumptionController {
  final ConsumptionService service = ConsumptionService();

  ConsumptionData? loadConsumption(String facilityId) {
    return service.getByFacilityId(facilityId);
  }
}
