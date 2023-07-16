import 'package:get/get.dart';
import 'package:smartup/data/core/services/dio_client.dart';
import 'package:smartup/data/course/data_source/remote/course_api_service.dart';
import 'package:smartup/data/course/repository/course_repository_impl.dart';
import 'package:smartup/domain/course/repository/course_repository.dart';
import 'package:smartup/domain/course/use_case/course_use_case.dart';

import 'exercise_question_controller.dart';

class ExerciseQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClientImpl(alice: Get.find()));
    Get.lazyPut<CourseApiService>(() => CourseApiServiceImpl(dioClient: Get.find()));
    Get.lazyPut<CourseRepository>(() => CourseRepositoryImpl(courseApiService: Get.find()));
    Get.lazyPut<CourseUseCase>(() => CourseUseCaseImpl(courseRepository: Get.find()));
    Get.lazyPut(() => ExerciseQuestionController(courseUseCase: Get.find()));
  }
}
