import 'package:get/get.dart';
import 'package:smartup/presentation/widgets/indicator_loading.dart';

abstract class LoadingDialog{
  static showLoading(){
    Get.dialog(const IndicatorLoading(), barrierDismissible: false);
  }

  static dismissLoading(){
    Get.back();
  }
}