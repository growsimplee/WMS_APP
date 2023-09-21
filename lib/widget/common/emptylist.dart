import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constant/colors.dart';
import 'customeelevatedbutton.dart';

class EmptyList extends StatelessWidget {
  EmptyList({
    Key? key,
    required this.asset,
    required this.mainText,
    required this.subText,
    this.buttonrequired = false,
    required this.ButtonText,
    required this.onPressed,

  }) : super(key: key);
  final VoidCallback onPressed;
  String asset;
  String mainText;
  String subText;
  bool buttonrequired = false;
  late String ButtonText ;



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          asset,
          height: 100,
          width: 100,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(mainText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(
          height: 10,
        ),
        Text(
          subText,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        if (buttonrequired) CustomElevatedButton(
          onPressed: onPressed,
          text: "$ButtonText",
          width: 200,
          color: ColorClass.baseColor,
          textcolor: Colors.white,
        ) else Container(),
      ],
    );
  }
}
