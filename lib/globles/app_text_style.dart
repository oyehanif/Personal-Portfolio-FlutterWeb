import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headerTextStyle({double fontSize = 36,Color color = Colors.white}) {
    return GoogleFonts.rubik(
        fontSize: fontSize, fontWeight: FontWeight.w600, color:color);
  }

  static TextStyle montserratStyle({Color color = Colors.white,  double fontSize = 24}) {
    return GoogleFonts.montserrat(
        fontSize: fontSize, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle headingStyles({double fontSize = 36, Color color = Colors.white}) {
    return GoogleFonts.rubikMoonrocks(
        fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2);
  }
    static TextStyle normalStyle(
      {Color color = Colors.white, double fontSize = 16}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
      letterSpacing: 1.7,
      height: 1.5,
    );
  }

  static TextStyle comfortaaStyle() {
    return GoogleFonts.comfortaa(
        fontSize: 18, fontWeight: FontWeight.w800, color: Colors.grey);
  }

}
