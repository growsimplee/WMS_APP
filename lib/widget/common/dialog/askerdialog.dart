import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constant/colors.dart';
import '../customeelevatedbutton.dart';

class Asker extends StatelessWidget {
  Asker(
      {Key? key,
      required this.title,
      required this.message,
      required this.yes,
      required this.no,
      required this.assetpath,
      required this.onPressedNo,
      required this.onPressedYes,
      this.color = ColorClass.baseColor,
      this.onlysubmit = false,
      this.dynamicArray})
      : super(key: key);

  String title;
  String message;
  String yes;
  String no;
  String assetpath;
  Color color = ColorClass.baseColor;
  final VoidCallback onPressedYes;
  final VoidCallback onPressedNo;
  Map<String, int>? dynamicArray = {};
  bool onlysubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetpath,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(
              height: 20,
            ),
            if (dynamicArray != null)
              Container(
                // You can adjust this height as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: dynamicArray!.entries.map((entry) {
                    return Row(
                      children: [
                        const Text(
                          "Sort Code : ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorClass.darkGrey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          entry.key,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 20), // Add spacing between text
                        Text(
                          entry.value.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorClass.darkGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      // Set actionsAlignment to MainAxisAlignment.spaceBetween
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        if (onlysubmit)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Expanded(
              child: CustomElevatedButton(
                onPressed: onPressedYes,
                text: yes,
                color: color,
                textcolor: Colors.white,
                fontSize: 13,
                width: double.infinity,
              ),
            ),
          ),
        if (!onlysubmit)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Evenly distribute buttons
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: onPressedNo,
                    text: no,
                    color: Colors.white,
                    textcolor: ColorClass.baseColor,
                    fontSize: 13,
                    width: 30,
                  ),
                ),
                SizedBox(width: 20), // Add spacing between buttons
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: onPressedYes,
                    text: yes,
                    color: color,
                    textcolor: Colors.white,
                    fontSize: 13,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
