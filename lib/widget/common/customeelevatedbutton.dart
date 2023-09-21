import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isDisabled = false,
    required this.width,
    required this.color,
    required this.textcolor,
    this.fontSize = 18,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool isDisabled;
  final double width;
  final Color color;
  final Color textcolor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: isDisabled
                  ? Colors.grey
                  : color == Colors.white
                      ? ColorClass.baseColor
                      : color,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: textcolor),
        ),
      ),
    );
  }
}
