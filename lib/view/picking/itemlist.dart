import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constant/colors.dart';
import '../../provider/picklistprovider.dart';
import '../../utilities/picklist/picklist.dart';
import '../../widget/common/listshimmer.dart';
import '../../widget/common/success.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  void initState() {
    super.initState();
    Provider.of<PicklistProvider>(context, listen: false).getItemList();
  }

  Widget build(BuildContext context) {
    var pickprovider = Provider.of<PicklistProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () async {
                bool value = await pickprovider.completePickList();
                if (value) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusPage(
                        title: '',
                        mainText: 'Picking Completed',
                        message: 'Picklist has been marked completed',
                        asset: 'assets/images/success.svg',
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Provider.of<PicklistProvider>(context, listen: false)
                              .onRefereh();
                          Provider.of<PicklistProvider>(context, listen: false)
                              .onRefereshItemlist();
                          Provider.of<PicklistProvider>(context, listen: false)
                              .onRefereshProductlist();
                          Provider.of<PicklistProvider>(context, listen: false)
                              .getActivePicklist(1);
                        },
                      ),
                    ),
                  );
                }
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text('Complete',
                      style: TextStyle(
                        color: pickprovider.totalactionItem ==
                                pickprovider.totalnumberofIteminAPicklits
                            ? ColorClass.baseMaterialColor
                            : ColorClass.baseMaterialColor.withOpacity(0.3),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<PicklistProvider>(context, listen: false)
                  .onRefereshItemlist();
              Provider.of<PicklistProvider>(context, listen: false).onRefereh();
              Provider.of<PicklistProvider>(context, listen: false)
                  .getActivePicklist(1);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff0D0D0D),
              size: 20,
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Picklists',
                    style: TextStyle(
                      color: Color(0xff0D0D0D),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: ColorClass.backgroundColor,
        body: Consumer<PicklistProvider>(
          builder: (context, picklistprovider, child) {
            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 60,
                      color: Colors.white,
                      child: const Align(
                        alignment: Alignment.center,
                        child: DottedLine(
                          lineLength: double.infinity,
                          dashLength: 3,
                          dashGapLength: 4,
                          lineThickness: 1,
                          dashColor: Color(0xffD9D9D9),
                          dashGapColor: Colors.transparent,
                          direction: Axis.horizontal,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0, // Adjust this value for overlap
                      child: Transform.translate(
                          offset:
                              Offset(0, -10), // Adjust this value for overlap
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xffC3C3C3), // Border color
                                width: 1, // Border width
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 50, right: 50, top: 5, bottom: 5),
                              child: Text(
                                picklistprovider.currentPicklistId.toString(),
                                style: const TextStyle(
                                  color: Color(0xff126782),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "No. of Items",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: ColorClass.darkGrey),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              picklistprovider.totalnumberofIteminAPicklits
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff3D5A80)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Actioned items",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: ColorClass.darkGrey),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '${picklistprovider.totalactionItem}/${picklistprovider.totalnumberofIteminAPicklits}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: ColorClass.baseColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                if (picklistprovider.getItemlistmessage == "")
                  Expanded(
                    child: Container(
                      child: const ListviewShimmer(),
                    ),
                  ),
                if (picklistprovider.getItemlistmessage != "" &&
                    picklistprovider.itemList.pendency!.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: picklistprovider.itemList.pendency?.length,
                      itemBuilder: (context, index) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 15, left: 10, right: 10, top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(50, 61, 68, 0.12),
                                    offset: Offset(0, 4),
                                    blurRadius: 14,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  picklistprovider.getselectedproductdetails(
                                      index + 1,
                                      picklistprovider.itemList.pendency![index]
                                              .productId ??
                                          0);
                                  await Navigator.pushNamed(
                                      context, '/picklist/items/productlist');
                                  if (mounted) {
                                    Provider.of<PicklistProvider>(context,
                                            listen: false)
                                        .onRefereshProductlist();
                                    Provider.of<PicklistProvider>(context,
                                            listen: false)
                                        .onRefereshItemlist();
                                    Provider.of<PicklistProvider>(context,
                                            listen: false)
                                        .getItemList();
                                  }
                                },
                                child: Card(
                                  elevation: 2,
                                  surfaceTintColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffF0EAFC),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  )),
                                              child: Padding(
                                                padding: EdgeInsets.all(12),
                                                child: Text(
                                                  (index + 1).toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          ColorClass.baseColor),
                                                ),
                                              )),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Color(int.parse(
                                                      Picklist.getItemListstatus(
                                                          picklistprovider
                                                              .itemList
                                                              .pendency![index]
                                                              .pickedQty!
                                                              .toInt(),
                                                          picklistprovider
                                                              .itemList
                                                              .pendency![index]
                                                              .total!
                                                              .toInt(),
                                                          picklistprovider
                                                                  .itemList
                                                                  .pendency![
                                                                      index]
                                                                  .available ??
                                                              true)[1])),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  )),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30,
                                                    right: 8,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Text(
                                                  Picklist.getItemListstatus(
                                                      picklistprovider
                                                          .itemList
                                                          .pendency![index]
                                                          .pickedQty!
                                                          .toInt(),
                                                      picklistprovider
                                                          .itemList
                                                          .pendency![index]
                                                          .total!
                                                          .toInt(),
                                                      picklistprovider
                                                              .itemList
                                                              .pendency![index]
                                                              .available ??
                                                          true)[0],
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(int.parse(
                                                          Picklist.getItemListstatus(
                                                              picklistprovider
                                                                  .itemList
                                                                  .pendency![
                                                                      index]
                                                                  .pickedQty!
                                                                  .toInt(),
                                                              picklistprovider
                                                                  .itemList
                                                                  .pendency![
                                                                      index]
                                                                  .total!
                                                                  .toInt(),
                                                              picklistprovider
                                                                      .itemList
                                                                      .pendency![
                                                                          index]
                                                                      .available ??
                                                                  true)[2]))),
                                                ),
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: ColorClass.baseColor
                                                    .withOpacity(0.05),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                  color: ColorClass.darkGrey
                                                      .withOpacity(0.2),
                                                  width: 1,
                                                ),
                                              ),
                                              child: SvgPicture.asset(
                                                "assets/images/no-imag.svg",
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "SKU Id",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: ColorClass
                                                                  .darkGrey),
                                                        ),
                                                        Text(
                                                          picklistprovider
                                                              .itemList
                                                              .pendency![index]
                                                              .productSkuId
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(width: 200),
                                                    Container(
                                                      height: 20,
                                                      width: 20,
                                                      child: SvgPicture.asset(
                                                        "assets/images/CaretDown.svg",
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 20),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Product Name",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: ColorClass
                                                              .darkGrey),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      picklistprovider
                                                          .itemList
                                                          .pendency![index]
                                                          .productName
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Qty to be Picked",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: ColorClass
                                                              .darkGrey),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      "${picklistprovider.itemList.pendency?[index].pickedQty}/${picklistprovider.itemList.pendency?[index].total}",
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
              ],
            );
          },
        ));
  }
}
