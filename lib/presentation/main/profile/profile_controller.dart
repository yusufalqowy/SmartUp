import 'package:get/get.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';
import 'package:smartup/route/routes.dart';

class ProfileController extends GetxController {

  final FirebaseAuthService firebaseAuthService;
  ProfileController({required this.firebaseAuthService});


  Future<void> logOut({bool isGotoLogin = true}) async {
    await firebaseAuthService.signOut();
    if(isGotoLogin){
      Get.offAllNamed(Routes.login);
    }
  }
}
