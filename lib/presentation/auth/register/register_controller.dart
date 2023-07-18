import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as Chat;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/user/model/register_user_request.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/domain/user/use_case/book_usecase.dart';

class RegisterController extends GetxController {
  final UserUseCase _userUseCase;

  RegisterController({required UserUseCase userUseCase}): _userUseCase = userUseCase;

  Rx<NetworkResponse<UserData>> register = Rx(NetworkResponse.init());

  Future<void> registerAccount(UserBody requestBody) async {
    register(NetworkResponse.loading());
    update();
    var response = await _userUseCase.registerUser(requestBody: requestBody);
    register(response);
    if(register.value.status.isSuccess){
      var user = response.data;
      var name = response.data?.userName?.split(" ");
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
  }
}
