
import 'package:flutter/cupertino.dart';
import 'package:wms_app/view/picking/itemlist.dart';
import 'package:wms_app/view/picking/pickinglist.dart';
import 'package:wms_app/view/picking/productlistinpicklist.dart';
import 'package:wms_app/view/scanner/scaningscreen.dart';
import '../view/auth/loginpage.dart';
import '../view/home/homepage.dart';

Map<String, WidgetBuilder> routes = {
  "/login": (context) => LoginPage(),
  "/home": (context) => const HomePage(),
  "/picklist": (context) => const PicklIST(),
  "/picklist/items": (context) => const ItemList(),
  "/picklist/items/productlist": (context) => const ProductListInPicklist(),
  "/scans": (context) => const ScaningScreen()
};
