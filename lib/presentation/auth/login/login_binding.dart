import 'package:get/get.dart';
import 'package:smartup/data/user/data_source/remote/user_api_service.dart';
import 'package:smartup/data/user/repository/user_repository_impl.dart';
import 'package:smartup/domain/user/repository/user_repository.dart';
import 'package:smartup/domain/user/use_case/book_usecase.dart';
import 'package:smartup/presentation/auth/login/login_controller.dart';
import 'package:smartup/data/core/services/dio_client.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClientImpl(alice: Get.find()));
    Get.lazyPut<UserApiService>(() => UserApiServiceImpl(dioClient: Get.find()));
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(userApiService: Get.find()));
    Get.lazyPut<UserUseCase>(() => UserUseCaseImpl(userRepository: Get.find()));
    Get.lazyPut<FirebaseAuthService>(() => FirebaseAuthServiceImpl());
    Get.lazyPut(() => LoginController(firebaseAuthService: Get.find(), userUseCase: Get.find()));
  }
}
