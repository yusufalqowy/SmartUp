import 'package:get_storage/get_storage.dart';
import 'package:smartup/presentation/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    // Get.lazyPut(() => GetStorage());
  }

}