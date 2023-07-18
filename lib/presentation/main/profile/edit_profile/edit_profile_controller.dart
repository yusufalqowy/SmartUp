import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/user/model/register_user_request.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/domain/user/use_case/book_usecase.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as Chat;

class EditProfileController extends GetxController {
  final UserUseCase userUseCase;

  EditProfileController({required this.userUseCase});

  Rx<NetworkResponse<UserData>> updateProfileState = Rx(NetworkResponse.init());

  Future<void> updateProfile({required UserBody requestBody}) async {
    updateProfileState(NetworkResponse.loading());
    update();
    var response = await userUseCase.updateUser(requestBody: requestBody);
    updateProfileState(response);
    if(updateProfileState.value.status.isSuccess){
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

  Future<NetworkResponse<UserData>> updateProfileImage({required UserBody requestBody}) async {
    return await userUseCase.updateUser(requestBody: requestBody);
  }
}
