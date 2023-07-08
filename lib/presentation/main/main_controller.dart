import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt navigationIndex = 0.obs;

  void navigateToIndex({required int index}){
    navigationIndex.value = index;
  }

}
