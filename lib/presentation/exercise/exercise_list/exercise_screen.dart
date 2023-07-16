import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/extensions.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';
import 'package:smartup/presentation/exercise/exercise_list/exercise_controller.dart';
import 'package:smartup/presentation/widgets/empty_item.dart';
import 'package:smartup/presentation/widgets/exercise_item.dart';
import 'package:smartup/presentation/widgets/exercise_skeleton.dart';
import 'package:smartup/presentation/widgets/gap.dart';

class ExerciseArgs {
  final String courseId;
  final String courseName;

  const ExerciseArgs({
    required this.courseId,
    required this.courseName,
  });
}

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  ExerciseController controller = Get.find();
  final FirebaseAuthService firebaseAuthService = Get.find();
  ExerciseArgs args = Get.arguments;

  @override
  void initState() {
    controller.getExercisesByCourse(courseId: args.courseId, email: firebaseAuthService.getCurrentSignedInUserEmail() ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(args.courseName), backgroundColor: colorScheme(context).primaryContainer,),
      body: RefreshIndicator(onRefresh: () { 
        return controller.getExercisesByCourse(courseId: args.courseId, email: firebaseAuthService.getCurrentSignedInUserEmail() ?? "");
      }, 
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(Dimens.d16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Pilih Paket Soal", style: TextStyles.title,),
              const Gap(),
              GetBuilder<ExerciseController>(builder: (controller){
                if (controller.exerciseResponseState.value.status.isSuccess) {
                  var exercise = controller.exerciseResponseState.value.data;
                  if (!exercise.isNullOrEmpty) {
                    return GridView.count(
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: Dimens.d8,
                      crossAxisSpacing: Dimens.d8,
                      shrinkWrap: true,
                      children: List.generate(exercise!.length, (index){
                        var exerciseData = exercise[index];
                        return ExerciseItem(exerciseData: exerciseData);
                      }),
                    );
                  } else {
                    return const EmptyItem(image: ImageAssets.imgEmpty, title: "Yah, Paket tidak tersedia", subtitle: "Tenang, masih banyak yang bisa kamu pelajari. Cari lagi yuk!",);
                  }
                } else if (controller.exerciseResponseState.value.status.isError) {
                  return Container(
                    margin: const EdgeInsets.all(Dimens.d16),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Gagal memuat data",
                            style: TextStyles.body2Text,
                          ),
                          TextButton.icon(
                            onPressed: () => controller.getExercisesByCourse(courseId: args.courseId,email: firebaseAuthService.getCurrentSignedInUserEmail() ?? ""),
                            icon: const Icon(Icons.refresh),
                            label: const Text("Refresh"),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return GridView.count(
                    crossAxisCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: Dimens.d8,
                    crossAxisSpacing: Dimens.d8,
                    shrinkWrap: true,
                    children: List.generate(10, (index){
                      return const ExerciseSkeleton();
                    }),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
