import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../constant/colors.dart';
import '../../provider/authprovider.dart';
import '../../provider/picklistprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    Provider.of<PicklistProvider>(context, listen: false).onRefereh();
    var response = Provider.of<PicklistProvider>(context, listen: false)
        .getActivePicklist(1);
  }

  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorClass.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child:
              Container(child: SvgPicture.asset("assets/images/warehouse.svg")),
        ),
        toolbarHeight: 75,
        actions: [
          Consumer<AuthProvider>(builder: (context, authProvider, child) {
            return TextButton(
              onPressed: () {
                authProvider.logOut().then((value) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF0D0D0D).withOpacity(0.3),
                  border: Border.all(color: Color(0xFFEDF2F4)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text('Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            );
          }),
        ],
        title: Padding(
          padding: EdgeInsets.all(10),
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dark Store',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  authprovider.warehousename,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: ColorClass.baseColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Warehouse Functions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<PicklistProvider>(
                  builder: (context, picklistprovider, child) {
                return Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: smallcardWidget(
                          context,
                          'Picking',
                          '/picklist',
                          'assets/images/picking.svg',
                          "",
                          picklistprovider.activepicklistList!.isNotEmpty
                              ? 'Pending ⚠️'
                              : "Great Job 👍",
                          picklistprovider.activepicklistList!.isNotEmpty
                              ? 0xffFF756C
                              : 0xff38B58B),
                    ),
                    Flexible(flex: 3, child: Container()),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

Widget smallcardWidget(
    BuildContext context,
    String title,
    String route,
    String assetPath,
    String ArrayLength,
    String statustext,
    int statustextboxbg) {
  return GestureDetector(
    onTap: () => {
      Navigator.pushNamed(context, route)
    }, // Call the provided onTap function when the card is tapped
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(50, 61, 68, 0.10),
            offset: Offset(0, 2),
            blurRadius: 14,
            spreadRadius: 0,
          ),
        ],
      ),
      height: 210,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(statustextboxbg), // Light grey background color
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
                child: Text(
                  statustext,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // Black text color
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 0, bottom: 15, top: 15),
              child: SvgPicture.asset(
                assetPath,
                height: 70,
                width: 70,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 0, bottom: 20, top: 0),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF126782)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 0),
                  child: Text(
                    ArrayLength,
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF126782)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
