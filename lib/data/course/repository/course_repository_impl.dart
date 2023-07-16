import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/course/data_source/remote/course_api_service.dart';
import 'package:smartup/data/course/model/course_response.dart';
import 'package:smartup/data/course/model/exercise_list_response.dart';
import 'package:smartup/data/course/model/exercise_result.dart';
import 'package:smartup/data/course/model/question_list_response.dart';
import 'package:smartup/domain/course/repository/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository{
  final CourseApiService courseApiService;
  const CourseRepositoryImpl({required this.courseApiService});

  @override
  Future<NetworkResponse<List<CourseData>>> getCourses({String majorName = "", required String email}) async => await courseApiService.getCourses(majorName: majorName, email: email);

  @override
  Future<NetworkResponse<ExerciseResultData>> getExerciseResult({required String exerciseId, required String email}) async => await courseApiService.getExerciseResult(exerciseId: exerciseId, email: email);

  @override
  Future<NetworkResponse<List<ExerciseData>>> getExercisesByCourse({required String courseId, required String email}) async => await courseApiService.getExercisesByCourse(courseId: courseId, email: email);

  @override
  Future<NetworkResponse<List<QuestionData>>> getQuestions({required String exerciseId, required String email}) async => await courseApiService.getQuestions(exerciseId: exerciseId, email: email);

  @override
  Future<NetworkResponse<bool>> submitAnswers({required String exerciseId, required List<String> questionIds, required List<String> answers, required String email}) async => await courseApiService.submitAnswers(exerciseId: exerciseId, questionIds: questionIds, answers: answers, email: email);



}