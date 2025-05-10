import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
Color buildColor(int r, int g, int b, double opacity) {
  return Color.fromRGBO(r, g, b, opacity);
}

Color cPrimary = buildColor(45, 51, 107, 1);
Color cTextWhite = buildColor(255, 255, 255, 1);
Color cTextBlue = buildColor(42, 45, 147, 1);
Color cLinear = buildColor(169, 181, 223, 1);
Color cWhite = buildColor(255, 255, 255, 1);
Color cBlack = buildColor(36, 36, 36, 1);
Color cGrey = buildColor(83, 83, 83, 1);
Color cError = buildColor(255, 34, 34, 1);
Color cSuccess = buildColor(0, 85, 0, 1);

// SizedBox

// Height: Vertical Space
const Widget hsSuperTiny = SizedBox(height: 4);
const Widget hsTiny = SizedBox(height: 8);
const Widget hsSmall = SizedBox(height: 12);
const Widget hsMedium = SizedBox(height: 16);
const Widget hsLarge = SizedBox(height: 24);
const Widget hsXLarge = SizedBox(height: 36);

// Width: Horizontal Space
const Widget vsSuperTiny = SizedBox(width: 4);
const Widget vsTiny = SizedBox(width: 8);
const Widget vsSmall = SizedBox(width: 12);
const Widget vsMedium = SizedBox(width: 16);
const Widget vsLarge = SizedBox(width: 24);
const Widget vsXLarge = SizedBox(width: 36);

// Border
OutlineInputBorder buildBorder({
  required Color color,
  double borderRadius = 5,
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    borderSide: BorderSide(color: color),
  );
}

OutlineInputBorder focusBorder = buildBorder(color: cPrimary);
OutlineInputBorder focusedErrorBorder = buildBorder(color: cError);
OutlineInputBorder errorBorder = buildBorder(color: cError);
OutlineInputBorder enabledBorder = buildBorder(color: cBlack);

// FontWeight
FontWeight buildFontWeight(int weight) {
  return FontWeight.values[(weight ~/ 100) - 1];
}

FontWeight fThin = buildFontWeight(100);
FontWeight fExtraLight = buildFontWeight(200);
FontWeight fLight = buildFontWeight(300);
FontWeight fRegular = buildFontWeight(400);
FontWeight fMedium = buildFontWeight(500);
FontWeight fSemiBold = buildFontWeight(600);
FontWeight fBold = buildFontWeight(700);
FontWeight fExtraBold = buildFontWeight(800);

// TextStyle
TextStyle buildTextStyle(double fontSize) {
  return GoogleFonts.poppins(fontSize: fontSize);
}

TextStyle tsHeadLine1 = buildTextStyle(40);
TextStyle tsHeadLine2 = buildTextStyle(34);
TextStyle tsHeadLine3 = buildTextStyle(24);
TextStyle tsHeadLine4 = buildTextStyle(20);
TextStyle tsSubtitle1 = buildTextStyle(16);
TextStyle tsSubtitle2 = buildTextStyle(14);
TextStyle tsCaption = buildTextStyle(12);
TextStyle tsOverline = buildTextStyle(10);
