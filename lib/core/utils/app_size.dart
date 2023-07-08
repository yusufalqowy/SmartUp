import 'package:get/get.dart';

abstract class AppSize{
  static double getWidth({double margin = 0}){
    return Get.width-margin;
  }

  static double getHeight({double margin = 0}){
    return Get.height-margin;
  }
}