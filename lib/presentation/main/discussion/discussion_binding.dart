import 'package:get/get.dart';

import 'discussion_controller.dart';

class DiscussionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscussionController());
  }
}
