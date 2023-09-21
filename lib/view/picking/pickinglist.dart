import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/provider/picklistprovider.dart';
import 'package:wms_app/widget/common/listshimmer.dart';

import '../../constant/colors.dart';
import '../../utilities/picklist/picklist.dart';
import '../../widget/common/emptylist.dart';

class PicklIST extends StatefulWidget {
  const PicklIST({super.key});

  @override
  State<PicklIST> createState() => _PicklISTState();
}

class _PicklISTState extends State<PicklIST> {
  @override
  void initState() {
    super.initState();
    Provider.of<PicklistProvider>(context, listen: false).getActivePicklist(1);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Provider.of<PicklistProvider>(context, listen: false).onRefereh();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
        ),
        elevation: 0,
        toolbarHeight: 85,
        title: const Padding(
          padding: EdgeInsets.all(10),
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Picklists',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Please choose a picklist to start picking',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
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
            const DottedLine(
              lineLength: double.infinity,
              dashLength: 2,
              dashGapLength: 4,
              lineThickness: 1,
              dashColor: Color(0xffD9D9D9),
              dashGapColor: ColorClass.baseMaterialColor,
              direction: Axis.horizontal,
            ),
            Container(
              decoration:
                  const BoxDecoration(color: ColorClass.baseMaterialColor),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pending Picklist',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          picklistprovider.pendingPicklist.toString(),
                          style: const TextStyle(
                            color: Color(0xffFFF500),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'No. of Items',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          picklistprovider.totalNumberOfItems.toString(),
                          style: const TextStyle(
                            color: Color(0xffFFF500),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (picklistprovider.errorMessage == "")
              Expanded(
                child: Container(
                  child: const ListviewShimmer(),
                ),
              ),
            if (picklistprovider.errorMessage != "" &&
                picklistprovider.activepicklistList!.isEmpty)
              Expanded(
                child: Container(
                    child: EmptyList(
                        asset: 'assets/images/Emptypicklist.svg',
                        mainText: 'Wait for New Picklist',
                        subText: '',
                        buttonrequired: false,
                        ButtonText: "",
                        onPressed: () => {})),
              ),
            if (picklistprovider.errorMessage != "" &&
                picklistprovider.activepicklistList!.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                      itemCount: picklistprovider.activepicklistList?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
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
                            child: Card(
                              elevation: 2,
                              surfaceTintColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              child: ListTile(
                                onTap: () {
                                  picklistprovider.getcurrentPicklistId(
                                      picklistprovider
                                              .activepicklistList![index].id ??
                                          0);
                                  Navigator.pushNamed(
                                      context, '/picklist/items');
                                },
                                title: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SvgPicture.asset(
                                              "assets/images/list.svg",
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                            Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Picklist Id",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorClass.darkGrey),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              picklistprovider
                                                  .activepicklistList![index].id
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                        ],
                                      ),
                                    
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(picklistprovider
                                                              .activepicklistList![
                                                                  index]
                                                              .status ==
                                                          "PENDING"
                                                      ? 0xffFFF1F0
                                                      : 0xffFCF5EC),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Text(
                                                  Picklist.getpickliststatus(
                                                      picklistprovider
                                                          .activepicklistList![
                                                              index]
                                                          .status
                                                          .toString()),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(picklistprovider
                                                                  .activepicklistList![
                                                                      index]
                                                                  .status ==
                                                              "PENDING"
                                                          ? 0xffFF756C
                                                          : 0xffE09F3E)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20,),
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
                                      )
                                    ]),
                                    Divider(
                                      color:
                                          ColorClass.darkGrey.withOpacity(0.2),
                                      thickness: 1,
                                    ),
                                    Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "No. of SKU",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorClass.darkGrey),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              picklistprovider
                                                  .activepicklistList![index]
                                                  .skuCount
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              picklistprovider
                                                  .activepicklistList![index]
                                                  .totalItems
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
          ],
        );
      }),
    );
  }
}
