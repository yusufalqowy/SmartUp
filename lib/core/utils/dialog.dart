import 'package:get/get.dart';
import 'package:smartup/presentation/widgets/indicator_loading.dart';

abstract class LoadingDialog{
  static showLoading(){
    if(Get.isDialogOpen == false){
      Get.dialog(const IndicatorLoading(), barrierDismissible: false);
    }
  }

  static dismissLoading(){
    if(Get.isDialogOpen == true){
      Get.back();
    }
  }
}