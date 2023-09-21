import 'package:wms_app/model/activepicklistmodel.dart';
import 'package:wms_app/model/itemlistmodel.dart';
import 'package:wms_app/model/productlistinbin.dart';

import 'baseservice.dart';

class PicklistService extends BaseApiService {
  Future<ActivePicklist> getactivepicklist(int currentPage) async {
    try {
      final body = {"type": "render_active_picklists"};
      final response = await sendRequest(
          '/inventory/outflow/pick/?ps=5&page=$currentPage',
          method: 'POST',
          body: body);
      return ActivePicklist.fromJson(response);
    } catch (e) {
      print('error in getRiders==>$e');
      rethrow;
    }
  }

  Future<Itemlistmodel> getitemslist(int picklistId) async {
    try {
      final body = {"type": "render_picklist", "picklist_id": picklistId};
      final response = await sendRequest('/inventory/outflow/pick/',
          method: 'POST', body: body);
      return Itemlistmodel.fromJson(response);
    } catch (e) {
      print('error in getRiders==>$e');
      rethrow;
    }
  }

  Future<ProductListInBin> getproductlistinbin(
      int picklistId, int productId) async {
    try {
      final body = {
        "type": "render_picklist_product",
        "product_id": productId,
        "picklist_id": picklistId
      };
      final response = await sendRequest('/inventory/outflow/pick/',
          method: 'POST', body: body);
      return ProductListInBin.fromJson(response);
    } catch (e) {
      print('error in getRiders==>$e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> pickItem(
      int picklistId, int productId, String barcode) async {
    try {
      final body = {
        "type": "pick_item",
        "product_id": productId,
        "picklist_id": picklistId,
        "code": barcode
      };
      final response = await sendRequest('/inventory/outflow/pick/',
          method: 'POST', body: body);
      return response;
    } catch (e) {
      print('error in getRiders==>$e');
      rethrow;
    }
  }
  Future<Map<String, dynamic>> completePickList(
      int picklistId) async {
    try {
      final body = {
        "type": "complete_picklist",
        "picklist_id": picklistId,
      };
      final response = await sendRequest('/inventory/outflow/pick/',
          method: 'POST', body: body);
      return response;
    } catch (e) {
      print('error in getRiders==>$e');
      rethrow;
    }
  }
}
