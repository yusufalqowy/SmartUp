import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => GetStorage());
  }
}
