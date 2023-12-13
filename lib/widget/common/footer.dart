import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Facing any issue? Contact Blitz',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorClass.darkGrey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '+91 98978 67687',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorClass.darkGrey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'support@blitznow.in',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorClass.darkGrey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
