// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_beep/flutter_beep.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/provider/scanprovider.dart';

import '../../constant/colors.dart';
import '../../provider/picklistprovider.dart';
import '../../widget/common/dialog/askerdialog.dart';

class ScaningScreen extends StatefulWidget {
  const ScaningScreen({super.key});

  @override
  State<ScaningScreen> createState() => _ScaningScreenState();
}

class _ScaningScreenState extends State<ScaningScreen> {
  MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.normal);
  @override
  Widget build(BuildContext context) {
    bool _isScanning = false;
    bool _alreadyScannedShown = false;
    var picklistprovider =
        Provider.of<PicklistProvider>(context, listen: false);
    String? barcode;
    return Consumer<ScanProvider>(builder: (context, scanprovider, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scanprovider.scanpagetitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => {
                cameraController.stop(),
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0))),
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                  right: 0,
                                  left: 0,
                                  top: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffF1F1F2),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0),
                                      ),
                                    ),
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 20.0, bottom: 20.0),
                                    child: const Text('Enter Barcode manually',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.0,
                                      left: 20.0,
                                    ),
                                    child: Text(
                                      'Enter manually barcode if barcode is not proper',
                                      style: TextStyle(
                                        color: Color(0XFF6E6E7A),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: scanprovider.manualAWB,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              hintText: 'Enter Barcode',
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 10, 10, 10),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                            autofocus: true,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        SizedBox(
                                          height: 45,
                                          width: 45,
                                          child: ElevatedButton(
                                            child: SvgPicture.asset(
                                              'assets/images/rightarrow.svg', // Replace with your image asset path
                                              width: 30,
                                              height: 30,
                                            ),
                                            onPressed: () {
                                              if (scanprovider.manualAWB.text !=
                                                  "") {
                                                scanprovider
                                                    .addBarcode(
                                                        scanprovider
                                                            .manualAWB.text,
                                                        scanprovider
                                                            .scaningtype)
                                                    .then((value) => {
                                                          if (value)
                                                            {
                                                              Navigator.pop(
                                                                  context),
                                                              FlutterBeep.beep(
                                                                  false),
                                                              if (scanprovider
                                                                      .errorMessage !=
                                                                  "Invalid AWB")
                                                                {
                                                                  if (picklistprovider
                                                                          .productlistinbin
                                                                          .pickingOrder!
                                                                          .isNotEmpty &&
                                                                      scanprovider
                                                                              .startingBin !=
                                                                          scanprovider
                                                                              .activebin)
                                                                    {
                                                                      Navigator.pop(
                                                                          context)
                                                                    },
                                                                  if (scanprovider
                                                                          .pendingItemtobescaned ==
                                                                      scanprovider
                                                                          .totalItem)
                                                                    {
                                                                      Navigator.pop(
                                                                          context),
                                                                      Navigator.pop(
                                                                          context)
                                                                    },
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text(
                                                                          "Item scaned successfully "),
                                                                      backgroundColor:
                                                                          ColorClass
                                                                              .appgreen,
                                                                    ),
                                                                  )
                                                                },
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          1250),
                                                                  content: Text(
                                                                      "Successfully Scanned"),
                                                                  backgroundColor:
                                                                      ColorClass
                                                                          .appgreen,
                                                                ),
                                                              ),
                                                            }
                                                          else
                                                            {
                                                              Navigator.pop(
                                                                  context),
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          1250),
                                                                  content: Text(
                                                                      scanprovider
                                                                          .errorMessage),
                                                                  backgroundColor:
                                                                      ColorClass
                                                                          .appred,
                                                                ),
                                                              ),
                                                            }
                                                        });
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              )),
                        ))
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: SvgPicture.asset(
                    "assets/images/manualawbenter.svg",
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(children: [
          Expanded(
            child: Stack(
              children: [
                MobileScanner(
                    controller: cameraController,
                    onDetect: (capture) async {
                      if (scanprovider.processing) {
                        return;
                      }
                      final List<Barcode> barcodes = capture.barcodes;
                      final String scannedbarcode =
                          barcodes[0].rawValue.toString();
                      if (barcode == scannedbarcode) {
                        return;
                      }
                      _isScanning =
                          scanprovider.scanBarcode.containsKey(scannedbarcode);
                      barcode = scannedbarcode;
                      setState(() {});
                      if (!_isScanning) {
                        if (barcodes[0].rawValue != null &&
                            !scanprovider.scanBarcode
                                .containsKey(scannedbarcode)) {
                          if (!scanprovider.processing) {
                            final value = await scanprovider.addBarcode(
                                scannedbarcode, scanprovider.scaningtype);
                            if (value) {
                              FlutterBeep.beep(false);
                              if (scanprovider.errorMessage != "Invalid AWB") {
                                if (picklistprovider.productlistinbin
                                        .pickingOrder!.isNotEmpty &&
                                    scanprovider.startingBin !=
                                        scanprovider.activebin) {
                                  Navigator.pop(context);
                                }
                                if (scanprovider.pendingItemtobescaned ==
                                    scanprovider.totalItem) {
                                  if (scanprovider.currentProductId ==
                                      picklistprovider
                                          .productlistinbin.productId) {
                                    Navigator.pop(context);
                                  } else {
                                    picklistprovider.getselectedproductdetails(
                                        picklistprovider
                                                .currectSerialNumberofProduct +
                                            1,
                                        scanprovider.currentProductId);
                                    showDialog(
                                      context: context,
                                      builder: (context) => Asker(
                                        onlysubmit: true,
                                        assetpath:
                                            'assets/images/success.svg',
                                        title: 'Item Picked Successfully',
                                        message:
                                            'Item has been picked, please move to the next item.',
                                        yes: 'Move to Next Item',
                                        no: '',
                                        onPressedNo: () {
                                          Navigator.pop(context, false);
                                        },
                                        onPressedYes: () async {
                                          Navigator.pop(context, false);
                                          Provider.of<PicklistProvider>(context,
                                                  listen: false)
                                              .onRefereshProductlist();
                                          Provider.of<PicklistProvider>(context,
                                                  listen: false)
                                              .getProductDetailsInABin();
                                        },
                                      ),
                                    );
                                  }
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Item scaned successfully "),
                                    backgroundColor: ColorClass.appgreen,
                                  ),
                                );
                              }
                            } else {
                              if (scanprovider.errorMessage != "Invalid AWB") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(scanprovider.errorMessage),
                                    backgroundColor: ColorClass.appred,
                                  ),
                                );
                              }
                            }
                          }
                        }
                      } else if (_isScanning) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 1250),
                            content: Text("Item Already scan"),
                            backgroundColor: ColorClass.appred,
                          ),
                        );
                      }
                    }),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Quantity Pending",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "${scanprovider.pendingItemtobescaned}/${scanprovider.totalItem}"
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xffFFF500)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      );
    });
  }
}
