import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  static Color primaryColor = HexColor("#359DD9");
  static Color secondaryColor = HexColor("#013A67");
  static Color darkBlue = HexColor("#013A67");
  static Color softGrey = HexColor("F9F9F9");
  static Color darkYellow = HexColor("#FFCC00");

  static final LinearGradient topNavigationBarColor= LinearGradient(
    colors: [primaryColor,secondaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final LinearGradient  bottomNavigationBarColor= LinearGradient(
    colors: [secondaryColor,primaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

}