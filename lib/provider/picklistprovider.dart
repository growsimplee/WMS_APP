import 'package:flutter/cupertino.dart';
import 'package:wms_app/model/activepicklistmodel.dart';
import 'package:wms_app/model/itemlistmodel.dart';
import 'package:wms_app/model/productlistinbin.dart';
import 'package:wms_app/services/picklistservice.dart';
import 'package:wms_app/view/picking/itemlist.dart';

class PicklistProvider extends ChangeNotifier {
  ActivePicklist activepicklist = ActivePicklist();
  Itemlistmodel itemList = Itemlistmodel();
  ProductListInBin productlistinbin = ProductListInBin();
  List<ActivePicklistResults>? activepicklistList = [];
  String errorMessage = "";
  String getItemlistmessage = "";
  String productlistinBinmessage = "";
  int? totalNumberOfItems = 0;
  int pendingPicklist = 0;
  int? currentPicklistId;
  int totalnumberofIteminAPicklits = 0;
  int totalactionItem = 0;
  int? currentProductId;
  int currectSerialNumberofProduct = 1;
  Future<ActivePicklist> getActivePicklist(int currentPage) async {
    try {
      activepicklist = await PicklistService().getactivepicklist(1);
      activepicklistList = activepicklist.results;
      for (var i in activepicklistList!) {
        totalNumberOfItems = (totalNumberOfItems! + i.totalItems!.toInt());
        if (i.status == "PENDING" || i.status == "STARTED") {
          pendingPicklist = pendingPicklist + 1;
        }
        notifyListeners();
      }
      errorMessage = 'Success';
      notifyListeners();
      return activepicklist;
    } catch (e) {
      errorMessage = 'Something went wrong.Try again';
      notifyListeners();
      rethrow;
    }
  }

  void getcurrentPicklistId(int picklistId) {
    currentPicklistId = picklistId;
    notifyListeners();
  }

  Future<Itemlistmodel> getItemList() async {
    try {
      itemList = await PicklistService().getitemslist(currentPicklistId ?? 0);
      for (var i in itemList.pendency!) {
        int totalItemactionalbel = 0;
        totalnumberofIteminAPicklits =
            totalnumberofIteminAPicklits + i.total!.toInt();
        totalactionItem = totalactionItem + i.pickedQty!.toInt();
      }
      getItemlistmessage = 'Success';
      notifyListeners();
      return itemList;
    } catch (e) {
      getItemlistmessage = 'Something went wrong.Try again';
      notifyListeners();
      rethrow;
    }
  }

  void getselectedproductdetails(int currectIndex, int productId) {
    currectSerialNumberofProduct = currectIndex;
    currentProductId = productId;
    notifyListeners();
  }

  Future<ProductListInBin> getProductDetailsInABin() async {
    try {
      productlistinbin = await PicklistService()
          .getproductlistinbin(currentPicklistId ?? 0, currentProductId!);
      productlistinBinmessage = 'Success';
      notifyListeners();
      return productlistinbin;
    } catch (e) {
      productlistinBinmessage = 'Something went wrong.Try again';
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> completePickList()async {
    var response = await PicklistService().completePickList(currentPicklistId ?? 0);
    return true;
  }

  void onRefereshProductlist() {
    productlistinBinmessage = '';
    notifyListeners();
  }

  void onRefereh() {
    errorMessage = '';
    totalNumberOfItems = 0;
    pendingPicklist = 0;
    notifyListeners();
  }

  void onRefereshItemlist() {
    totalnumberofIteminAPicklits = 0;
    totalactionItem = 0;
    getItemlistmessage = '';
    notifyListeners();
  }
}
