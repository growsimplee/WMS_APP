import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms_app/model/warehousedetailmodel.dart';
import 'package:wms_app/services/authservice.dart';
import 'package:wms_app/services/warehousedetailservoce.dart';

class AuthProvider extends ChangeNotifier {
  String username = "";
  String password = "";
  String errorText = '';
  String errormessage = '';
  WarehouseDetail warehouseDetail = WarehouseDetail();
  String warehousename = "";

  void setUserName(String phoneNumber) {
    username = phoneNumber;
    notifyListeners();
  }

  void setPassword(String newpassword) {
    password = newpassword;
    notifyListeners();
  }

  Future<bool> login() async {
    var response = await AuthService().loginapi(username, password);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    if (response['code'] != 200) {
      errormessage = response['message'];
      notifyListeners();
      return false;
    } else {
      prefs.setString('token', response['id_token']);
      prefs.setString('refreshToken', response['refresh_token']);
      print("referesh_token${response['referesh_token']}");
      errormessage = "";
      warehouseDetail = await WarehouseDetailService().gerwarehousedata();
      warehousename = warehouseDetail.response![0].warehouseName.toString();
      notifyListeners();
      return true;
    }
  }

  Future<String> loadconfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('refreshToken')) {
      var responseOfToken = await AuthService().tokenReferesh(
          prefs.getString("username"), prefs.getString("refreshToken"));
      if (responseOfToken == null) {
        return "login";
      }
      List<String>? token = responseOfToken;
      prefs.setString('token', token![0]);
      warehouseDetail = await WarehouseDetailService().gerwarehousedata();
      warehousename = warehouseDetail.response![0].warehouseName.toString();
      notifyListeners();
      return 'home';
    } else {
      return "login";
    }
  }

  logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('refreshToken');
    prefs.remove('hubName');
    prefs.remove('phoneNo');
    prefs.remove('name');
    String username = "";
    String password = "";
    notifyListeners();
  }
}
