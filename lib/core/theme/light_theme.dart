import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_editor_flutter2/core/colors/colors.dart';

CupertinoThemeData cupertinoTheme = const CupertinoThemeData(
  primaryColor: kWhite,
);

ThemeData lightTheme = ThemeData(
  primaryColor: kBlack,
  primaryColorLight: kWhite,
  cardColor: kGreyLight,
  scaffoldBackgroundColor: kBlack,
  primaryColorDark: kGrey,
  focusColor: kOrange,
  fontFamily: 'Gilroy',
  primaryTextTheme: const TextTheme(
    titleMedium: TextStyle(
      color: kWhite,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: kWhite,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: kWhite,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      color: kWhite,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      color: kWhite,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
  ),
);
