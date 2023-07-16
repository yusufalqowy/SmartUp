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
    update();
  }
}
