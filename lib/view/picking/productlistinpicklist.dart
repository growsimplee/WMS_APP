import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/provider/scanprovider.dart';

import '../../constant/colors.dart';
import '../../provider/picklistprovider.dart';
import '../../utilities/picklist/picklist.dart';
import '../../widget/common/customeelevatedbutton.dart';
import '../../widget/common/listshimmer.dart';

class ProductListInPicklist extends StatefulWidget {
  const ProductListInPicklist({super.key});

  @override
  State<ProductListInPicklist> createState() => _ProductListInPicklistState();
}

class _ProductListInPicklistState extends State<ProductListInPicklist> {
  @override
  void initState() {
    super.initState();
    Provider.of<PicklistProvider>(context, listen: false)
        .getProductDetailsInABin();
  }

  Widget build(BuildContext context) {
    int currentserialNumber =
        Provider.of<PicklistProvider>(context, listen: false)
            .currectSerialNumberofProduct;
            

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff0D0D0D),
            size: 20,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.all(10),
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Picklists',
                  style: TextStyle(
                    color: Color(0xff0D0D0D),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Sr No.',
                      style: TextStyle(
                        color: Color(0xff0D0D0D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      currentserialNumber.toString(),
                      style: const TextStyle(
                        color: Color(0xff0D0D0D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ColorClass.backgroundColor,
      body: Consumer2<PicklistProvider, ScanProvider>(
          builder: (context, picklistprovider, scanprovider, child) {
        return Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  const DottedLine(
                    lineLength: double.infinity,
                    dashLength: 3,
                    dashGapLength: 4,
                    lineThickness: 1,
                    dashColor: Color(0xffD9D9D9),
                    dashGapColor: Colors.transparent,
                    direction: Axis.horizontal,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 20, left: 20, bottom: 10),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: picklistprovider
                                              .productlistinbin.productId ==
                                          null
                                      ? Radius.circular(6)
                                      : (picklistprovider.productlistinbin
                                                  .summary!.length >
                                              1
                                          ? Radius.circular(0)
                                          : Radius.circular(6)),
                                  bottomRight: picklistprovider
                                              .productlistinbin.productId ==
                                          null
                                      ? Radius.circular(6)
                                      : (picklistprovider.productlistinbin
                                                  .summary!.length >
                                              1
                                          ? Radius.circular(0)
                                          : Radius.circular(6)),
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6)),
                              color: Color(0xffF0EAFC)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Pick From",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: ColorClass.darkGrey),
                                ),
                                SizedBox(height: 6),
                                Text(
                                   picklistprovider.productlistinbin.productId == null ? "" :
                                 (picklistprovider.productlistinbin
                                          .pickingOrder!.isNotEmpty
                                      ? (picklistprovider.productlistinbin
                                              .pickingOrder![0].binName ??
                                          "")
                                      : ""),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: ColorClass.baseColor),
                                )
                              ],
                            ),
                          ),
                        ),
                        if(picklistprovider.productlistinbin.productId != null)
                        if (picklistprovider.productlistinbin.summary!.length >
                            1)
                          GestureDetector(
                            onTap: () => {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0),
                                        ),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffF1F1F2)
                                                  .withOpacity(0.3),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                topRight: Radius.circular(16.0),
                                              ),
                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                right: 20,
                                                left: 20),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Bins to Pick",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: picklistprovider
                                                    .productlistinbin
                                                    .summary
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Color(
                                                                0xffA0C2CD), // Border color
                                                            width:
                                                                1.0, // Border thickness
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              decoration: const BoxDecoration(
                                                                  color: Color(
                                                                      0xffECF3F5),
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              6),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              6))),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Bin : ${picklistprovider.productlistinbin.summary![index].binName}",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Color(0xff0066FF)),
                                                                    ),
                                                                    if (picklistprovider
                                                                            .productlistinbin
                                                                            .pickingOrder![
                                                                                0]
                                                                            .binName ==
                                                                        picklistprovider
                                                                            .productlistinbin
                                                                            .summary![index]
                                                                            .binName)
                                                                    if(picklistprovider.productlistinbin.pickingOrder!.isNotEmpty)
                                                                      Container(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            const Text(
                                                                              "Selected",
                                                                              style: TextStyle(color: Color(0xff01A831), fontSize: 14, fontWeight: FontWeight.w400),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            SvgPicture.asset(
                                                                              "assets/images/tick.svg",
                                                                              height: 25,
                                                                              width: 25,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                                child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Row(
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        "Picked QTY",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: ColorClass.darkGrey),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              6),
                                                                      Text(
                                                                        "${picklistprovider.productlistinbin.summary![index].pickedQty}/${picklistprovider.productlistinbin.summary![index].pickedQty!.toInt() + picklistprovider.productlistinbin.summary![index].pendingQty!.toInt()}",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 40,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        "status",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: ColorClass.darkGrey),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              6),
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(6),
                                                                            color: Color(int.parse(Picklist.getmultiplebinstatus(picklistprovider.productlistinbin.summary![index].pickedQty!.toInt(), picklistprovider.productlistinbin.summary![index].pickedQty!.toInt() + picklistprovider.productlistinbin.summary![index].pendingQty!.toInt())[1]))),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            Picklist.getmultiplebinstatus(picklistprovider.productlistinbin.summary![index].pickedQty!.toInt(),
                                                                                picklistprovider.productlistinbin.summary![index].pickedQty!.toInt() + picklistprovider.productlistinbin.summary![index].pendingQty!.toInt())[0],
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color(int.parse(Picklist.getmultiplebinstatus(picklistprovider.productlistinbin.summary![index].pickedQty!.toInt(), picklistprovider.productlistinbin.summary![index].pickedQty!.toInt() + picklistprovider.productlistinbin.summary![index].pendingQty!.toInt())[2])),
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ))
                                                          ]),
                                                    ),
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    );
                                  })
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color(0xffE6DAFF),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6))),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Multiple Bins",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SvgPicture.asset(
                                        "assets/images/CaretDownblack.svg",
                                        height: 15,
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (picklistprovider.productlistinBinmessage == "")
              Expanded(
                child: Container(
                  child: const ListviewShimmer(),
                ),
              ),
            if (picklistprovider.productlistinBinmessage != "")
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Card(
                          elevation: 2,
                          surfaceTintColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(int.parse(
                                        Picklist.getproductListinBinstatus(
                                            picklistprovider
                                                .productlistinbin.pickedQty!
                                                .toInt(),
                                            picklistprovider
                                                .productlistinbin.total!
                                                .toInt())[1])),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6))),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    Picklist.getproductListinBinstatus(
                                        picklistprovider
                                            .productlistinbin.pickedQty!
                                            .toInt(),
                                        picklistprovider.productlistinbin.total!
                                            .toInt())[0],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "SKU",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: ColorClass.darkGrey),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          picklistprovider.productlistinbin
                                                  .productSkuId ??
                                              "",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff3D5A80)),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Pick QTY",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorClass.darkGrey),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              "${picklistprovider.productlistinbin.pickedQty}/${picklistprovider.productlistinbin.total}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: ColorClass.baseColor),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Product Name",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: ColorClass.darkGrey),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      picklistprovider
                                              .productlistinbin.productName ??
                                          "",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff3D5A80)),
                                    )
                                  ],
                                )),
                              ),
                              Container(
                                width: double.infinity,
                                child: SvgPicture.asset(
                                  "assets/images/no_imag_big.svg",
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
            Container(
              height: 100,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 30),
                child: CustomElevatedButton(
                  color: ColorClass.baseColor,
                  text: 'Scan Item',
                  onPressed: () async {
                    scanprovider.getscanningdetails(
                        "Pick and Scan Items",
                        "picking",
                        picklistprovider.currentProductId,
                        picklistprovider.currentPicklistId,
                        picklistprovider.productlistinbin.pickingOrder![0].binName,
                        picklistprovider
                                .productlistinbin.pickingOrder![0].pickedQty!
                                .toInt(),
                        picklistprovider
                                .productlistinbin.pickingOrder![0].pendingQty!
                                .toInt() +
                            picklistprovider
                                .productlistinbin.pickingOrder![0].pickedQty!
                                .toInt());
                    await  Navigator.pushNamed(context, '/scans');
                    if (mounted){
                     Provider.of<PicklistProvider>(context, listen: false).getProductDetailsInABin(); 
                    }
                  },
                  textcolor: Colors.white,
                  width: double.infinity,
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
