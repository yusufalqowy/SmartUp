import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/domain/repository/user_repository.dart';
import 'package:smartup/route/routes.dart';

class LoginController extends GetxController{
  final FirebaseAuthService firebaseAuthService;
  final UserRepository userRepository;

  LoginController({required this.firebaseAuthService, required this.userRepository});

  Rx<NetworkResponse<UserData>> login = Rx(NetworkResponse.init());
  Rx<User?> userEmail = Rx(null);

  /// Steps:
  /// 1. Sign In With Google
  /// 2. Get Email from UserCredential
  /// 3. Check isUserRegistered()
  Future<void> onGoogleSignIn() async {
    User? user = await firebaseAuthService.signInWithGoogle();
    userEmail(user);
    update();
    if (user != null) {
      await isUserRegistered();
    }
  }

  Future<void> logOut({bool isGotoLogin = true}) async {
    await firebaseAuthService.signOut();
    if(isGotoLogin){
      Get.offAllNamed(Routes.login);
    }
  }

  Future<void> isUserRegistered() async {
    String? email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      login(NetworkResponse.loading());
      update();
      var userData = await userRepository.getUserByEmail(email: email);
      login(userData);
      update();
    } else {
      login(NetworkResponse.error(message: "Terjadi kesalahan, mohon coba lagi!"));
      update();
    }
  }
}