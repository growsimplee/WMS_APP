import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/services/picklistservice.dart';

import '../model/productlistinbin.dart';

class ScanProvider extends ChangeNotifier {
  String scanpagetitle = "";
  String scaningtype = "";
  bool processing = false;
  Map<String, String> scanBarcode = {};
  int? currentProductId;
  int? currentPicklistId;
  String errorMessage = "";
  int? totalItem;
  int? pendingItemtobescaned;
  ProductListInBin productlistinbin = ProductListInBin();
  String startingBin = "";
  String activebin = "";
  TextEditingController manualAWB = TextEditingController();

  void getscanningdetails(title, scantype, productId, picklistid, binName,
      pendingItem, totalscanningitem) {
    scanpagetitle = title;
    scaningtype = scantype;
    currentProductId = productId;
    currentPicklistId = picklistid;
    pendingItemtobescaned = pendingItem;
    totalItem = totalscanningitem;
    startingBin = binName;
    notifyListeners();
  }

  Future<bool> addBarcode(String barcode, String scanType) async {
    if (scanBarcode.containsKey(barcode)) {
      errorMessage = 'Item already added';
      processing = false;
      notifyListeners();
      return false;
    } else if (processing) {
      errorMessage = 'Still Processing';
      notifyListeners();
      return false;
    }
    processing = true;
    notifyListeners();
    if (scaningtype == "picking") {
      var response = await PicklistService()
          .pickItem(currentPicklistId!, currentProductId!, barcode);
      if (response['success'] == true) {
        productlistinbin = await PicklistService()
            .getproductlistinbin(currentPicklistId ?? 0, currentProductId!);
        pendingItemtobescaned = productlistinbin.pickingOrder!.isNotEmpty
            ? productlistinbin.pickingOrder![0].pickedQty
            : totalItem;
        activebin = (productlistinbin.pickingOrder!.isNotEmpty
            ? productlistinbin.pickingOrder![0].binName
            : "")!;
        currentProductId = productlistinbin.nextProduct ?? productlistinbin.productId ;
        processing = false;
        manualAWB.text = '';  
        notifyListeners();
        return true;
      } else {
        errorMessage = response['message'];
        processing = false;
        manualAWB.text = '';
        notifyListeners();
        return false;
      }
    }
    return false;
  }
}
