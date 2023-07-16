import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/utils/dialog.dart';
import 'package:smartup/core/utils/extensions.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_alert.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/presentation/widgets/page_number_exercise.dart';
import 'package:smartup/presentation/widgets/question_item.dart';
import 'package:smartup/presentation/widgets/question_skeleton.dart';
import 'package:smartup/presentation/widgets/skeleton.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smartup/route/routes.dart';

import 'exercise_question_controller.dart';

class ExerciseQuestionArgs {
  final String exerciseId;

  const ExerciseQuestionArgs({required this.exerciseId});
}

class ExerciseQuestionScreen extends StatefulWidget {
  const ExerciseQuestionScreen({super.key});

  @override
  State<ExerciseQuestionScreen> createState() => _ExerciseQuestionScreenState();
}

class _ExerciseQuestionScreenState extends State<ExerciseQuestionScreen> {
  final FirebaseAuthService firebaseAuthService = Get.find();
  final controller = Get.find<ExerciseQuestionController>();
  final ExerciseQuestionArgs args = Get.arguments;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  List<int> showedItem = [];

  @override
  void initState() {
    controller.getQuestions(
        exerciseId: args.exerciseId,
        email: firebaseAuthService.getCurrentSignedInUserEmail() ?? "");
    itemPositionsListener.itemPositions.addListener(() {
      showedItem = itemPositionsListener.itemPositions.value
          .where((element) => element.itemLeadingEdge >= 0 && element.itemTrailingEdge <= 1)
          .map((e) => e.index)
          .toList();
    });
    /*WidgetsBinding.instance
        .addPostFrameCallback((_) => handleSubmit(context, controller));*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latihan Soal"),
        backgroundColor: colorScheme(context).primaryContainer,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: colorScheme(context).surface,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: EdgeInsets.zero,
              collapseMode: CollapseMode.pin,
              background: Container(
                color: colorScheme(context).surface,
              ),
              title: GetBuilder<ExerciseQuestionController>(builder: (ctrl) {
                var response = ctrl.questionResponseState.value;
                if (response.status.isSuccess) {
                  var data = ctrl.listQuestion;
                  if (data.isNotEmpty) {
                    return ScrollablePositionedList.separated(
                        padding: const EdgeInsets.symmetric(horizontal: Dimens.d8),
                        scrollDirection: Axis.horizontal,
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return PageNumberExercise(
                            index: index,
                            status: getNumberStatus(index, ctrl),
                            onTap: (idx) => ctrl.navigateToPage(idx),
                          );
                        },
                        separatorBuilder: (context, pos) {
                          return const Gap(
                            w: Dimens.d8,
                          );
                        });
                  } else {
                    return const SizedBox();
                  }
                } else if (response.status.isError) {
                  return const SizedBox();
                } else {
                  return ListView.separated(
                      padding: const EdgeInsets.all(Dimens.d8),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const Skeleton(
                          height: 50,
                          width: 50,
                          shape: BoxShape.circle,
                        );
                      },
                      separatorBuilder: (context, pos) {
                        return const Gap(
                          w: Dimens.d8,
                        );
                      });
                }
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(Dimens.d16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetBuilder<ExerciseQuestionController>(builder: (ctrl) {
                    var response = ctrl.questionResponseState.value;
                    if (response.status.isSuccess) {
                      var activeQuestion = ctrl.listQuestion[ctrl.page.value];
                      return QuestionItem(
                          key: UniqueKey(),
                          questionData: activeQuestion,
                          page: ctrl.page.value,
                          optionSelected: (answer) {
                            activeQuestion.studentAnswer = answer;
                            ctrl.listQuestion[ctrl.page.value] = activeQuestion;
                          });
                    } else if (response.status.isError) {
                      return const SizedBox();
                    } else {
                      return const QuestionSkeleton();
                    }
                  }),
                  const Gap(),
                ],
              ),
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        GetBuilder<ExerciseQuestionController>(builder: (ctrl) {
          Future.delayed(Duration.zero,() => handleSubmit(context, ctrl));
          // print("Masuk");
          var response = ctrl.questionResponseState.value;
          if (response.status.isSuccess) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: Dimens.d8),
              child: Row(
                children: [
                  Expanded(
                      child: FilledButton(
                    onPressed: () {
                      var index = controller.page.value - 1;
                      gotoPage(index, controller);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Icon(Icons.arrow_back), Text("Sebelumnya")],
                    ),
                  )),
                  const Gap(
                    w: Dimens.d8,
                  ),
                  Expanded(
                      child: FilledButton(
                    onPressed: () {
                      if(ctrl.page.value == ctrl.listQuestion.length-1){
                        Get.bottomSheet(
                            BottomSheetAlert(
                              title: "Kumpulkan latihan soal sekarang?",
                              message: "Boleh langsung kumpulin dong",
                              image: SvgPicture.asset(
                                ImageAssets.imgCollect,
                                fit: BoxFit.fitHeight,
                                height: 120,
                              ),
                              positiveButton: FilledButton(
                                  onPressed: () {
                                    Get.back();
                                    var questionIds = ctrl.listQuestion.map((e) => e.questionId ?? "").toList();
                                    var answers = ctrl.listQuestion.map((e) => e.studentAnswer.isAcceptAnswer ? e.studentAnswer! : "X").toList();
                                    ctrl.submitAnswers(exerciseId: args.exerciseId, questionIds: questionIds, answers: answers, email: firebaseAuthService.getCurrentSignedInUserEmail() ?? "");
                                  },
                                  child: const Text("Ya")),
                              negativeButton: FilledButton.tonal(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("Nanti Dulu"),
                              ),
                            ),
                            backgroundColor: colorScheme(context).surface);
                      }else{
                        var index = controller.page.value + 1;
                        gotoPage(index, controller);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(ctrl.page.value != ctrl.listQuestion.length-1 ? "Selanjutnya" : "Kumpulin"), Icon(ctrl.page.value != ctrl.listQuestion.length-1 ? Icons.arrow_forward : Icons.check)],
                    ),
                  )),
                ],
              ),
            );
          } else if (response.status.isError) {
            return const SizedBox();
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: Dimens.d8),
              child: const Row(
                children: [
                  Expanded(
                    child: Skeleton(
                      height: 40,
                      cornerRadius: 40,
                    ),
                  ),
                  Gap(
                    w: Dimens.d8,
                  ),
                  Expanded(
                    child: Skeleton(
                      height: 40,
                      cornerRadius: 40,
                    ),
                  ),
                ],
              ),
            );
          }
        })
      ],
    );
  }

  PageNumberStatus getNumberStatus(
      int index, ExerciseQuestionController controller) {
    if (controller.listQuestion.isNotEmpty) {
      var question = controller.listQuestion[index];
      if (controller.page.value == index) {
        return PageNumberStatus.active;
      } else {
        if (question.studentAnswer.isAcceptAnswer) {
          return PageNumberStatus.answered;
        } else {
          return PageNumberStatus.unAnswered;
        }
      }
    }
    return PageNumberStatus.unAnswered;
  }

  void gotoPage(int index, ExerciseQuestionController controller) {
    if (index >= 0 && index < controller.listQuestion.length) {
      if (!showedItem.contains(index)) {
        itemScrollController.scrollTo(
            index: index, duration: 500.milliseconds, alignment: 0.5);
      }
      controller.navigateToPage(index);
    }
  }

  handleSubmit(BuildContext context, ExerciseQuestionController controller) {
    var responseSubmit = controller.submitAnswerResponseState.value;
    var responseResult = controller.getResultResponseState.value;
    switch (responseSubmit.status) {
      case NetworkStatus.loading:
        LoadingDialog.showLoading();
        break;
      case NetworkStatus.error:
        LoadingDialog.dismissLoading();
        Get.bottomSheet(
            BottomSheetAlert(
              title: "Error",
              message: responseSubmit.message ?? "Unknown Error",
              image: SvgPicture.asset(
                ImageAssets.imgSorry,
                fit: BoxFit.fitHeight,
                height: 150,
              ),
              negativeButton: FilledButton.tonal(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Tutup"),
              ),
            ),
            backgroundColor: colorScheme(context).surface);
        break;
      default:
        break;
    }

    switch (responseResult.status) {
      case NetworkStatus.success:
        LoadingDialog.dismissLoading();
        if(responseResult.data != null && responseResult.data?.result != null){
          Get.offAllNamed(Routes.exerciseResult, arguments: responseResult.data?.result);
        }
        break;
      case NetworkStatus.error:
        LoadingDialog.dismissLoading();
        Get.bottomSheet(
            BottomSheetAlert(
              title: "Error",
              message: responseResult.message ?? "Unknown Error",
              image: SvgPicture.asset(
                ImageAssets.imgSorry,
                fit: BoxFit.fitHeight,
                height: 150,
              ),
              negativeButton: FilledButton.tonal(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Tutup"),
              ),
            ),
            backgroundColor: colorScheme(context).surface);
        break;
      default:
        // LoadingDialog.dismissLoading();
        break;
    }
  }
}
