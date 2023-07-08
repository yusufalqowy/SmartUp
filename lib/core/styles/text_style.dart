import 'package:flutter/material.dart';
import 'package:smartup/core/values/font_size.dart';

abstract class TextStyles{
  static const selectedNavigationLabel = TextStyle(fontSize: FontSize.s12, fontWeight: FontWeight.w500,);
  static const unselectedNavigationLabel = TextStyle(fontSize: FontSize.s12, fontWeight: FontWeight.normal, height: 2);
  static const title = TextStyle(fontSize: FontSize.s16, fontWeight: FontWeight.w600);
  static const subTitle = TextStyle(fontSize: FontSize.s12, fontWeight: FontWeight.w400);
  static const headerSection = TextStyle(fontSize: FontSize.s16, fontWeight: FontWeight.w700);
  static const linkText = TextStyle(fontSize: FontSize.s12, fontWeight: FontWeight.w500,);
  static const bannerText = TextStyle(fontSize: FontSize.s20, fontWeight: FontWeight.w700, height: 1.5,);
  static const highlightText = TextStyle(fontSize: FontSize.s20, fontWeight: FontWeight.w600,);
  static const body1Text = TextStyle(fontSize: FontSize.s16, fontWeight: FontWeight.w400,);
  static const body2Text = TextStyle(fontSize: FontSize.s14, fontWeight: FontWeight.w400,);
  static const body3Text = TextStyle(fontSize: FontSize.s12, fontWeight: FontWeight.w400,);
}