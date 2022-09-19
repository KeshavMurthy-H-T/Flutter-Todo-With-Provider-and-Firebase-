import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static TextStyle textlableStyle(BuildContext context) => GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
        letterSpacing: 0.5,
      ));

  static TextStyle buttonTextlableStyle(BuildContext context) =>
      GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.5,
      ));

  static TextStyle formtextStyle(BuildContext context) => GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.5,
      ));

  static TextStyle sideMenuHeaderStyle(BuildContext context) =>
      GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.4,
      ));

  static TextStyle sideMenuTextStyle(BuildContext context) =>
      GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        letterSpacing: 0.4,
      ));

  static TextStyle appBarTextStyle(BuildContext context) => GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
        letterSpacing: 0.2,
      ));

  static TextStyle textHeader(BuildContext context) => GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
        letterSpacing: 0.5,
      ));

  static TextStyle textHeaderwithColor(BuildContext context, color) {
    return GoogleFonts.raleway(
        // ignore: prefer_const_constructors
        textStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 0.5,
    ));
  }

  static TextStyle textHeaderBoldwithColor(BuildContext context, color) {
    return GoogleFonts.raleway(
        // ignore: prefer_const_constructors
        textStyle: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w900,
      color: color,
      letterSpacing: 0.5,
    ));
  }

  static TextStyle bodytext(BuildContext context) => GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        letterSpacing: 0.6,
      ));

  static TextStyle bodytext1(BuildContext context) => GoogleFonts.lato(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        letterSpacing: 0.6,
      ));
  static TextStyle bodyBoldText(BuildContext context) => GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
        letterSpacing: 0.6,
      ));

  static TextStyle bodyBoldText1(BuildContext context) => GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 0.6,
      ));

  static TextStyle bodyErrorText(BuildContext context) => GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 0.6,
      ));

      static TextStyle numberTextStyle(BuildContext context) =>
      GoogleFonts.raleway(
          // ignore: prefer_const_constructors
          textStyle: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.4,
      ));
}
