import 'package:smartup/core/values/urls.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/core/services/dio_client.dart';
import 'package:smartup/data/course/model/course_response.dart';
import 'package:smartup/data/course/model/exercise_list_response.dart';
import 'package:smartup/data/course/model/exercise_result.dart';
import 'package:smartup/data/course/model/question_list_response.dart';
import 'package:smartup/data/course/model/submit_exercise_response.dart';

abstract class CourseApiService{
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

class CourseApiServiceImpl implements CourseApiService{
  final DioClient dioClient;
  const CourseApiServiceImpl({required this.dioClient});

  @override
  Future<NetworkResponse<List<CourseData>>> getCourses({String majorName = "", required String email}) async {
    try{
      var queryParam = {
        "major_name":majorName,
        "user_email":email
      };
      var response = await dioClient.get(Urls.courseList, queryParameters: queryParam);
      if(response.statusCode == 200){
        if(response.data != null){
          var courseResponse = CourseResponse.fromJson(response.data);
          if(courseResponse.status == 0){
            return NetworkResponse.error(message: courseResponse.message);
          }
          return NetworkResponse.success(courseResponse.data);
        }else{
          return NetworkResponse.error(message: response.statusMessage);
        }
      }else{
        return NetworkResponse.error(message: response.statusMessage);
      }
    }catch(e){
      return NetworkResponse.error(message: e.toString());
    }
  }

  @override
  Future<NetworkResponse<ExerciseResultData>> getExerciseResult({required String exerciseId, required String email}) async {
    try{
      var queryParam = {
        "exercise_id":exerciseId,
        "user_email":email
      };
      var response = await dioClient.get(Urls.exerciseResult, queryParameters: queryParam);
      if(response.statusCode == 200){
        if(response.data != null){
          var exerciseResponse = ExerciseResultResponse.fromJson(response.data);
          /*if(exerciseResponse.status == 0){
            return NetworkResponse.error(message: exerciseResponse.message);
          }*/
          return NetworkResponse.success(exerciseResponse.data);
        }else{
          return NetworkResponse.error(message: response.statusMessage);
        }
      }else{
        return NetworkResponse.error(message: response.statusMessage);
      }
    }catch(e){
      return NetworkResponse.error(message: e.toString());
    }
  }

  @override
  Future<NetworkResponse<List<ExerciseData>>> getExercisesByCourse({required String courseId, required String email}) async {
    try{
      var queryParam = {
        "course_id":courseId,
        "user_email":email
      };
      var response = await dioClient.get(Urls.exerciseList, queryParameters: queryParam);
      if(response.statusCode == 200){
        if(response.data != null){
          var exerciseResponse = ExerciseListResponse.fromJson(response.data);
          /*if(exerciseResponse.status == 0){
            return NetworkResponse.error(message: exerciseResponse.message);
          }*/
          return NetworkResponse.success(exerciseResponse.data);
        }else{
          return NetworkResponse.error(message: response.statusMessage);
        }
      }else{
        return NetworkResponse.error(message: response.statusMessage);
      }
    }catch(e){
      return NetworkResponse.error(message: e.toString());
    }
  }

  @override
  Future<NetworkResponse<List<QuestionData>>> getQuestions({required String exerciseId, required String email}) async {
    try{
      var queryParam = {
        "exercise_id":exerciseId,
        "user_email":email
      };
      var response = await dioClient.post(Urls.exerciseQuestionsList, body: queryParam);
      if(response.statusCode == 200){
        if(response.data != null){
          var exerciseResponse = QuestionResponse.fromJson(response.data);
          /*if(exerciseResponse.status == 0){
            return NetworkResponse.error(message: exerciseResponse.message);
          }*/
          return NetworkResponse.success(exerciseResponse.data);
        }else{
          return NetworkResponse.error(message: response.statusMessage);
        }
      }else{
        return NetworkResponse.error(message: response.statusMessage);
      }
    }catch(e){
      return NetworkResponse.error(message: e.toString());
    }
  }

  @override
  Future<NetworkResponse<bool>> submitAnswers({required String exerciseId, required List<String> questionIds, required List<String> answers, required String email}) async {
    try{
      var body = {
        "exercise_id":exerciseId,
        "user_email":email,
        "bank_question_id":questionIds,
        "student_answer":answers,
      };
      var response = await dioClient.post(Urls.submitExerciseAnswers, body: body);
      if(response.statusCode == 200){
        if(response.data != null){
          var exerciseResponse = ExerciseSubmitResponse.fromJson(response.data);
          if(exerciseResponse.status == 0){
            return NetworkResponse.error(message: exerciseResponse.message);
          }
          return NetworkResponse.success(true);
        }else{
          return NetworkResponse.error(message: response.statusMessage);
        }
      }else{
        return NetworkResponse.error(message: response.statusMessage);
      }
    }catch(e){
      return NetworkResponse.error(message: e.toString());
    }
  }


}