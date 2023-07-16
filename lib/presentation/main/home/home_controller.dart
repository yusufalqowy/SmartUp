import 'package:get/get.dart';
import 'package:smartup/data/banner/model/banner_response.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/course/model/course_response.dart';
import 'package:smartup/domain/banner/use_case/banner_use_case.dart';
import 'package:smartup/domain/course/use_case/course_use_case.dart';

class HomeController extends GetxController {
  final BannerUseCase _bannerUseCase;
  final CourseUseCase _courseUseCase;

  HomeController({required BannerUseCase bannerUseCase, required CourseUseCase courseUseCase}) : _bannerUseCase = bannerUseCase, _courseUseCase = courseUseCase;

  Rx<NetworkResponse<List<BannerData>>> bannerResponseState = Rx(NetworkResponse.init());
  Rx<NetworkResponse<List<CourseData>>> courseResponseState = Rx(NetworkResponse.init());

  Future<void> getEventBanner({required int limit}) async {
    bannerResponseState(NetworkResponse.loading());
    update();
    var response = await _bannerUseCase.getEventBanner(limit: limit);
    bannerResponseState(response);
    update();
  }

  Future<void> getCourses({String majorName = "", required String email}) async {
    courseResponseState(NetworkResponse.loading());
    update();
    var response = await _courseUseCase.getCourses(majorName: majorName, email: email);
    courseResponseState(response);
    update();
  }


}
