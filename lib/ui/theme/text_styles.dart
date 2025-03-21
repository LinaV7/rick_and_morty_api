import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle headline1(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textWhite
          : AppColors.textBlack,
    );
  }

  static TextStyle headline2(BuildContext context) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textWhite
          : AppColors.textBlack,
    );
  }

  static TextStyle headline3(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textWhite
          : AppColors.textBlack,
    );
  }

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.lightGray,
  );

  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textWhite
          : AppColors.textBlack,
    );
  }
}
