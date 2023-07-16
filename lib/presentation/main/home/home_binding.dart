import 'package:get/get.dart';
import 'package:smartup/data/banner/data_source/remote/banner_api_service.dart';
import 'package:smartup/data/banner/repository/banner_repository_impl.dart';
import 'package:smartup/data/core/services/dio_client.dart';
import 'package:smartup/data/course/data_source/remote/course_api_service.dart';
import 'package:smartup/data/course/repository/course_repository_impl.dart';
import 'package:smartup/domain/banner/repository/banner_repository.dart';
import 'package:smartup/domain/banner/use_case/banner_use_case.dart';
import 'package:smartup/domain/course/repository/course_repository.dart';
import 'package:smartup/domain/course/use_case/course_use_case.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DioClient>(DioClientImpl(alice: Get.find()));
    Get.put<BannerApiService>(BannerApiServiceImpl(dioClient:Get.find()));
    Get.put<BannerRepository>(BannerRepositoryImpl(bannerApiService: Get.find()));
    Get.put<BannerUseCase>(BannerUseCaseImpl(bannerRepository: Get.find()));
    Get.put<CourseApiService>(CourseApiServiceImpl(dioClient: Get.find()));
    Get.put<CourseRepository>(CourseRepositoryImpl(courseApiService: Get.find()));
    Get.put<CourseUseCase>(CourseUseCaseImpl(courseRepository: Get.find()));
    Get.put(HomeController(bannerUseCase: Get.find(), courseUseCase: Get.find()));
  }
}
