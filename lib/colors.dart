import 'package:flutter/material.dart';

class HexColor extends Color {
 static int _getColorFromHex(String hexColor) {
   hexColor = hexColor.toUpperCase().replaceAll('#', '');
   if (hexColor.length == 6) {
     hexColor = 'FF' + hexColor;
   }
   return int.parse(hexColor, radix: 16);
 }

 HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

abstract class MyColors {
  static var black1 = HexColor("f5f8ff");
  static var black2 = HexColor("14161c");
  static var gray = HexColor("2d3746");
  static var red1 = HexColor("ff0000");
  static var red2 = HexColor("da0000");
  static var blue1 = HexColor("0da0fc");
  static var blue2 = HexColor("0071da");
  static var yellow = HexColor("ffc429");
  static var error = HexColor("ee0664");
}
