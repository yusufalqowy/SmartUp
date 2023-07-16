import 'package:get/get.dart';
import 'package:smartup/core/utils/extensions.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/course/model/exercise_result.dart';
import 'package:smartup/data/course/model/question_list_response.dart';
import 'package:smartup/domain/course/use_case/course_use_case.dart';

class ExerciseQuestionController extends GetxController {
  final CourseUseCase _courseUseCase;
  ExerciseQuestionController({required CourseUseCase courseUseCase}): _courseUseCase=courseUseCase;

  Rx<NetworkResponse<List<QuestionData>>> questionResponseState = Rx(NetworkResponse.init());
  Rx<NetworkResponse<bool>> submitAnswerResponseState = Rx(NetworkResponse.init());
  Rx<NetworkResponse<ExerciseResultData>> getResultResponseState = Rx(NetworkResponse.init());
  List<QuestionData> listQuestion = <QuestionData>[];
  Rx<int> page = Rx(0);

  Future<void> submitAnswers({required String exerciseId, required List<String> questionIds, required List<String> answers, required String email, }) async {
    submitAnswerResponseState(NetworkResponse.loading());
    update();
    var response = await _courseUseCase.submitAnswers(exerciseId: exerciseId, questionIds: questionIds, answers: answers, email: email);
    if(response.data == true){
      var result = await getExerciseResult(exerciseId: exerciseId, email: email);
      getResultResponseState(result);
      update();
    }else{
      submitAnswerResponseState(response);
      update();
    }

  }

  Future<void> getQuestions({required String exerciseId, required String email}) async {
    questionResponseState(NetworkResponse.loading());
    update();
    var response = await _courseUseCase.getQuestions(exerciseId: exerciseId, email: email);
    questionResponseState(response);
    if(!response.data.isNullOrEmpty){
      listQuestion.clear();
      listQuestion.addAll(response.data!);
    }
    update();
  }

  Future<NetworkResponse<ExerciseResultData>> getExerciseResult({required String exerciseId, required String email}) async{
    return await _courseUseCase.getExerciseResult(exerciseId: exerciseId, email: email);

  }

  void navigateToPage(int newPage){
    if(newPage >= 0 && newPage < listQuestion.length){
      page(newPage);
      update();
    }
  }
}
