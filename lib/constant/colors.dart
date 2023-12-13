import 'package:flutter/material.dart';

class ColorClass {
  static const Color baseColor = Color(0xFF692BE0);
  static const Color darkGrey = Color(0xFF4E4E4E);
  static const Color golden = Color(0xFFE09F3E);
  static const Color appgreen = Color(0xFF01A831);
  static const Color appred = Color(0xFFFF756C);
  static const Color apppeach = Color(0xFFFFF1CC);
  static const Color apppink= Color(0xFFF72585);
  static const Color backgroundColor= Color(0xfffedf2f4);

  static const MaterialColor baseMaterialColor = MaterialColor(
  0xFF692BE0,
  <int, Color>{
    50: Color(0xFF8A71FF),  // 10%
    100: Color(0xFF815DF9), // 20%
    200: Color(0xFF7649F3), // 30%
    300: Color(0xFF6B35ED), // 40%
    400: Color(0xFF6111E7), // 50%
    500: Color(0xFF571DE1), // 60%
    600: Color(0xFF4D09DB), // 70%
    700: Color(0xFF4305D5), // 80%
    800: Color(0xFF3801CF), // 90%
    900: Color(0xFF2E00C9), // 100%
  },
);
}
