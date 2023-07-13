import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartup/data/core/services/dio_client.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';
import 'package:smartup/data/user/data_source/remote/user_api_service.dart';
import 'package:smartup/data/user/repository/user_repository_impl.dart';
import 'package:smartup/domain/repository/user_repository.dart';
import 'package:smartup/domain/use_case/book_usecase.dart';

import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClientImpl(alice: Get.find()));
    Get.lazyPut<UserApiService>(() => UserApiServiceImpl(dioClient: Get.find()));
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(userApiService: Get.find()));
    Get.lazyPut<UserUseCase>(() => UserUseCaseImpl(userRepository: Get.find()));
    Get.lazyPut<FirebaseAuthService>(() => FirebaseAuthServiceImpl());
    Get.lazyPut(() => RegisterController(userUseCase: Get.find()));
  }
}
