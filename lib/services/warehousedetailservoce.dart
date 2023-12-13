import 'package:wms_app/model/warehousedetailmodel.dart';

import 'baseservice.dart';

class WarehouseDetailService extends BaseApiService {
  Future<WarehouseDetail> gerwarehousedata() async {
    try {
      final response =
          await sendRequest("/inventory/warehouse/app", method: 'GET');
      print("response345$response");
      return WarehouseDetail.fromJson(response);
    } catch (e) {
      print('error in getCodDepositData==>$e');
      rethrow;
    }
  }
}
