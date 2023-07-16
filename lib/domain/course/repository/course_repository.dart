import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/course/model/course_response.dart';
import 'package:smartup/data/course/model/exercise_list_response.dart';
import 'package:smartup/data/course/model/exercise_result.dart';
import 'package:smartup/data/course/model/question_list_response.dart';

abstract class CourseRepository{
  Future<NetworkResponse<List<CourseData>>> getCourses({String majorName, required String email});

  Future<NetworkResponse<List<ExerciseData>>> getExercisesByCourse({required String courseId, required String email});

  Future<NetworkResponse<List<QuestionData>>> getQuestions({required String exerciseId, required String email});

  Future<NetworkResponse<bool>> submitAnswers({
    required String exerciseId,
    required List<String> questionIds,
    required List<String> answers,
    required String email,
  });

  Future<NetworkResponse<ExerciseResultData>> getExerciseResult({required String exerciseId, required String email});
}