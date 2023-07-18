import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as Chat;
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/domain/user/use_case/book_usecase.dart';
import 'package:smartup/route/routes.dart';

class LoginController extends GetxController{
  final FirebaseAuthService firebaseAuthService;
  final UserUseCase userUseCase;

  LoginController({required this.firebaseAuthService, required this.userUseCase});

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
      var userData = await userUseCase.getUserByEmail(email: email);
      login(userData);
      if(login.value.status.isSuccess){
        var user = userData.data;
        var name = userData.data?.userName?.split(" ");
        String lastName = "";
        name?.getRange(1, name.length).forEach((element) { lastName += "$element "; });
        await FirebaseChatCore.instance.createUserInFirestore(
          Chat.User(
            firstName: name?.first ?? "",
            id: FirebaseChatCore.instance.firebaseUser?.uid ?? "",
            imageUrl: user?.userFoto,
            lastName: lastName.isEmpty ? null : lastName.trimRight(),
          ),
        );
      }
      update();
    } else {
      login(NetworkResponse.error(message: "Terjadi kesalahan, mohon coba lagi!"));
      update();
    }
  }
}