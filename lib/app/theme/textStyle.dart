import 'package:flutter/material.dart';
import 'color.dart';

class FTextStyle {
  static const TextStyle headerTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: FColors.primaryDarkColor);

  static const TextStyle simpleTextStyleBlack = TextStyle(color: Colors.black,fontSize: 17);

  static const TextStyle boldTextStyleBlack =
  TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  static const TextStyle boldTextStyleBlackFifteen =
  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);

  static const TextStyle boldTextStyleBlue =
  TextStyle(color:FColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 19);

  static const TextStyle simpleTextStyleGrey = TextStyle(color: Colors.grey,fontSize: 17);
  static const TextStyle simpleTextStyleTheme =
  TextStyle(color: FColors.primaryDarkColor);
  static const TextStyle boldTextStyleGrey =
  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold);

  static const TextStyle textFielhintStyleGrey =
  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold);

  static const TextStyle textFieldStyleblack =
  TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  static const TextStyle boldTextStyleTheme =
  TextStyle(color: FColors.primaryDarkColor,fontSize: 17, fontWeight: FontWeight.bold);

  static const TextStyle headerWhiteTextStyle =
  TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold);

  static const TextStyle headerBlackTextStyle =
  TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold);

  static const TextStyle headerRedTextStyle =
  TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold);

  static const TextStyle textErrorStyle =
  TextStyle(color: Colors.red, fontSize:12, fontWeight: FontWeight.normal);
  /// add
  static  TextStyle headerGreyTextStyleHeading =
  const TextStyle(color: Colors.grey, fontSize: 19, fontWeight: FontWeight.bold);
  static  TextStyle headerGreyTextStyle =
  const TextStyle(color: Colors.grey, fontSize:17, fontWeight: FontWeight.normal);
  static const TextStyle whiteBoldSixteen =
  TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold);
  static const TextStyle themeBoldTwenty = TextStyle(
      color: FColors.primaryDarkColor,
      fontSize: 22,
      fontWeight: FontWeight.bold);

  static const TextStyle middleTextStyleBlack= TextStyle(color: Colors.black,fontSize: 20);

}
