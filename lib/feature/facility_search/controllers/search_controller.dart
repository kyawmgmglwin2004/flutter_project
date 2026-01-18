import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ntt/core/route/app_route.dart';
import 'package:ntt/feature/facility_search/services/facility_service.dart';
import 'package:ntt/feature/facility_search/widgets/error_dialog.dart';
import 'package:ntt/mock/consumption_mock_data.dart';

class FacilitySearchController extends ChangeNotifier {
  final TextEditingController facilityController = TextEditingController();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final FacilityService service = FacilityService();

  bool isLoading = false;

  Future<void> search(BuildContext context) async{
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    final id = facilityController.text;
    ConsumptionData? result = await service.findFacilityById(id);

    isLoading = false;
    notifyListeners();

    if(result == null){
      showErrorDialog(context);
    }else {
      await storage.write(key: 'facilityId', value: id);
      Navigator.pushReplacementNamed(context, AppRoute.consumption, arguments: id);
    }
  }
  @override
  void disponse(){
    facilityController.dispose();
    super.dispose();
  }
}