import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const Color cPrimary = Color.fromRGBO(45, 51, 107, 1);
const Color cTextWhite = Color.fromRGBO(255, 255, 255, 1);
const Color cTextBlue = Color.fromRGBO(78, 75, 102, 1);
const Color cLinear = Color.fromRGBO(169, 181, 223, 1);
const Color cWhite = Color.fromRGBO(255, 255, 255, 1);
const Color cBlack = Color.fromRGBO(36, 36, 36, 1);
const Color cGrey = Color.fromRGBO(83, 83, 83, 1);
const Color cError = Color.fromRGBO(255, 34, 34, 1);
const Color cRequired = Color.fromRGBO(255, 69, 69, 1);
const Color cSuccess = Color.fromRGBO(0, 85, 0, 1);

// SizedBox

// Height: Vertical Space
var customvs = (int size) => SizedBox(height: size.toDouble());

const Widget vsSuperTiny = SizedBox(height: 4);
const Widget vsTiny = SizedBox(height: 8);
const Widget vsSmall = SizedBox(height: 12);
const Widget vsMedium = SizedBox(height: 16);
const Widget vsLarge = SizedBox(height: 24);
const Widget vsXLarge = SizedBox(height: 36);

// Width: Horizontal Space
var customhs = (int size) => SizedBox(width: size.toDouble());

const Widget hsSuperTiny = SizedBox(width: 4);
const Widget hsTiny = SizedBox(width: 8);
const Widget hsSmall = SizedBox(width: 12);
const Widget hsMedium = SizedBox(width: 16);
const Widget hsLarge = SizedBox(width: 24);
const Widget hsXLarge = SizedBox(width: 36);

// Border
OutlineInputBorder buildBorder({
  required Color color,
  double borderRadius = 6,
  double borderWidth = 1,
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    borderSide: BorderSide(color: color, width: borderWidth),
  );
}

OutlineInputBorder focusBorder = buildBorder(color: cPrimary);
OutlineInputBorder focusedErrorBorder = buildBorder(color: cError);
OutlineInputBorder errorBorder = buildBorder(color: cError);
OutlineInputBorder enabledBorder = buildBorder(color: cBlack);

// FontWeight
FontWeight buildFontWeight(int weight) {
  return FontWeight.values[weight ~/ 100];
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
// TextStyle tsHeadLine1 = GoogleFonts.poppins(fontSize: 40);
// TextStyle tsHeadLine2 = GoogleFonts.poppins(fontSize: 34);
// TextStyle tsHeadLine3 = GoogleFonts.poppins(fontSize: 24);
// TextStyle tsHeadLine4 = GoogleFonts.poppins(fontSize: 20);
// TextStyle tsSubtitle1 = GoogleFonts.poppins(fontSize: 16);
// TextStyle tsSubtitle2 = GoogleFonts.poppins(fontSize: 14);
// TextStyle tsCaption = GoogleFonts.poppins(fontSize: 12);
// TextStyle tsOverline = GoogleFonts.poppins(fontSize: 10);

// Font Sizes
const double tsHeadLine1 = 40;
const double tsHeadLine2 = 34;
const double tsHeadLine3 = 24;
const double tsHeadLine4 = 20;
const double tsSubtitle1 = 16;
const double tsSubtitle2 = 14;
const double tsCaption = 12;
const double tsOverline = 10;

TextStyle poppinsStyle({
  required double fontSize,
  FontWeight fontWeight = FontWeight.w400,
  Color color = Colors.black,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}
