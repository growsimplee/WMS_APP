import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
// import 'package:flutter_beep/flutter_beep.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/provider/scanprovider.dart';

import '../../constant/colors.dart';
import '../../provider/picklistprovider.dart';

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
                                  Navigator.pop(context);
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
