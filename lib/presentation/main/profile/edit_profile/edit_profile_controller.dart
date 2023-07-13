import 'package:get/get.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/user/model/register_user_request.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/domain/use_case/book_usecase.dart';

class EditProfileController extends GetxController {
  final UserUseCase userUseCase;

  EditProfileController({required this.userUseCase});

  Rx<NetworkResponse<UserData>> updateProfileState = Rx(NetworkResponse.init());

  Future<void> updateProfile({required UserBody requestBody}) async {
    updateProfileState(NetworkResponse.loading());
    update();
    var response = await userUseCase.updateUser(requestBody: requestBody);
    updateProfileState(response);
    update();
  }
}
