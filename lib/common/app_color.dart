import 'package:flutter/material.dart';

class AppColors {
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color colorPrimary = Color(0xFF2C3B5D);
  static const Color item1 = Color(0xFF28E0AE);
  static const Color item2 = Color(0xFFFF0090);
  static const Color item3 = Color(0xFFFFAE00);
  static const Color item4 = Color(0xFF0090FF);
  static const Color item5 = Color(0xFFDC0000);
  static const Color item6 = Color(0xFF0051FF);
}
final List<Color> colorList = [
  AppColors.item1,
  AppColors.item2,
  AppColors.item3,
  AppColors.item4,
  AppColors.item5,
  AppColors.item6,
];
Color getColorAtIndex(int index) {
  return colorList[index % colorList.length];
}