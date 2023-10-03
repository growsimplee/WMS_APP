import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  List<ActivePicklistResults>? copyactiveList = [];
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
  int? currentBinId;
  int totalPicklistPage = 0;
  int? nextproductId;
  RefreshController refreshControllerPicklist =
      RefreshController(initialRefresh: false);
  Future<ActivePicklist> getActivePicklist(int currentPage) async {
    try {
      copyactiveList?.clear();
      activepicklist = await PicklistService().getactivepicklist(currentPage);
      copyactiveList = activepicklist.results;
      totalPicklistPage = activepicklist.pages!;
      for(var i in copyactiveList!){
          activepicklistList?.add(i);
      }
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
        if(i.available == false){
          totalactionItem = totalactionItem + i.total!;
        }
        else{
         totalactionItem = totalactionItem + i.pickedQty!.toInt();
        }
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

  void getselectedproductdetails(int currectIndex, int? productId) {
    currectSerialNumberofProduct = currectIndex;
    currentProductId = productId;
    notifyListeners();
  }

  Future<ProductListInBin> getProductDetailsInABin() async {
    try {
      productlistinbin = await PicklistService()
          .getproductlistinbin(currentPicklistId ?? 0, currentProductId!);
      currentBinId = productlistinbin.pickingOrder![0].binId;
      nextproductId = productlistinbin.nextProduct;
      productlistinBinmessage = 'Success';
      notifyListeners();
      return productlistinbin;
    } catch (e) {
      productlistinBinmessage = 'Something went wrong.Try again';
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> completePickList() async {
    var response =
        await PicklistService().completePickList(currentPicklistId ?? 0);
    return true;
  }

  Future<bool> markItemInAbinstatus(String reason) async {
    var response = await PicklistService().markstatusforitem(
        currentPicklistId ?? 0, currentProductId!, currentBinId! ,reason);
      print("response45$response");
      if(response['available']){
          return true;
      }
      else{
       return false;
      }
    
  }

  void onRefereshProductlist() {
    productlistinBinmessage = '';
    notifyListeners();
  }

  void onRefereh() {
    errorMessage = '';
    totalNumberOfItems = 0;
    activepicklistList?.clear();
    pendingPicklist = 0;
    refreshControllerPicklist.loadComplete();
    notifyListeners();
  }

  void onRefereshItemlist() {
    totalnumberofIteminAPicklits = 0;
    totalactionItem = 0;
    getItemlistmessage = '';
    notifyListeners();
  }
}
