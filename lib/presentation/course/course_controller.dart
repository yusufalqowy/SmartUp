import 'package:get/get.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/course/model/course_response.dart';
import 'package:smartup/domain/course/use_case/course_use_case.dart';

class CourseController extends GetxController {
  final CourseUseCase _courseUseCase;
  CourseController({required CourseUseCase courseUseCase}): _courseUseCase=courseUseCase;

  Rx<NetworkResponse<List<CourseData>>> courseResponseState = Rx(NetworkResponse.init());

  Future<void> getCourses({String majorName = "", required String email}) async {
    courseResponseState(NetworkResponse.loading());
    update();
    var response = await _courseUseCase.getCourses(majorName: majorName, email: email);
    courseResponseState(response);
    update();
  }


}
