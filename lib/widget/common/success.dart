import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constant/colors.dart';
import 'customeelevatedbutton.dart';

class StatusPage extends StatelessWidget {
  StatusPage(
      {Key? key,
      required this.title,
      required this.mainText,
      required this.message,
      required this.asset,
      required this.onPressed})
      : super(key: key);

  String title;
  String mainText;
  String message;
  String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                SvgPicture.asset(
                  asset,
                  height: 80,
                  width: 80,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(mainText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorClass.darkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomElevatedButton(
                    onPressed: onPressed,
                    text: 'Back',
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: Colors.white,
                    textcolor: ColorClass.baseColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
