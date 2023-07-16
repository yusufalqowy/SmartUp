import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/course/model/course_response.dart';
import 'package:smartup/data/course/model/exercise_list_response.dart';
import 'package:smartup/data/course/model/exercise_result.dart';
import 'package:smartup/data/course/model/question_list_response.dart';
import 'package:smartup/domain/course/repository/course_repository.dart';

abstract class CourseUseCase{
  Future<NetworkResponse<List<CourseData>>> getCourses({String majorName, required String email});

  Future<NetworkResponse<List<ExerciseData>>> getExercisesByCourse({required String courseId, required String email});

  Future<NetworkResponse<List<QuestionData>>> getQuestions({required String exerciseId, required String email});

  Future<NetworkResponse<bool>> submitAnswers({
    required String exerciseId,
    required List<String> questionIds,
    required List<String> answers,
    required String email,
  });

  Future<NetworkResponse<ExerciseResultData>> getExerciseResult({required String exerciseId, required String email});}

class CourseUseCaseImpl implements CourseUseCase{
  final CourseRepository courseRepository;
  const CourseUseCaseImpl({required this.courseRepository});

  @override
  Future<NetworkResponse<List<CourseData>>> getCourses({String majorName = "", required String email}) async => await courseRepository.getCourses(majorName: majorName, email: email);

  @override
  Future<NetworkResponse<ExerciseResultData>> getExerciseResult({required String exerciseId, required String email}) async => await courseRepository.getExerciseResult(exerciseId: exerciseId, email: email);

  @override
  Future<NetworkResponse<List<ExerciseData>>> getExercisesByCourse({required String courseId, required String email}) async => await courseRepository.getExercisesByCourse(courseId: courseId, email: email);

  @override
  Future<NetworkResponse<List<QuestionData>>> getQuestions({required String exerciseId, required String email}) async => await courseRepository.getQuestions(exerciseId: exerciseId, email: email);

  @override
  Future<NetworkResponse<bool>> submitAnswers({required String exerciseId, required List<String> questionIds, required List<String> answers, required String email}) async => await courseRepository.submitAnswers(exerciseId: exerciseId, questionIds: questionIds, answers: answers, email: email);

}