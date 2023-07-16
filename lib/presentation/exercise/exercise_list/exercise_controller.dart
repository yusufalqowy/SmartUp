import 'package:get/get.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/course/model/exercise_list_response.dart';
import 'package:smartup/domain/course/use_case/course_use_case.dart';

class ExerciseController extends GetxController {
  final CourseUseCase _courseUseCase;
  ExerciseController({required CourseUseCase courseUseCase}): _courseUseCase=courseUseCase;

  Rx<NetworkResponse<List<ExerciseData>>> exerciseResponseState = Rx(NetworkResponse.init());

  Future<void> getExercisesByCourse({required String courseId, required String email}) async {
    exerciseResponseState(NetworkResponse.loading());
    update();
    var response = await _courseUseCase.getExercisesByCourse(courseId: courseId, email: email);
    exerciseResponseState(response);
    update();
  }
}
