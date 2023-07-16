import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/data/course/model/exercise_list_response.dart';
import 'package:smartup/presentation/exercise/exercise_question/exercise_question_screen.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:get/get.dart';
import 'package:smartup/route/routes.dart';

class ExerciseItem extends StatelessWidget {
  final ExerciseData exerciseData;
  const ExerciseItem({super.key, required this.exerciseData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.d8)),
      child: InkWell(
        onTap: () => Get.toNamed(Routes.exerciseQuestion, arguments: ExerciseQuestionArgs(exerciseId: exerciseData.exerciseId ?? "")),
        child: Container(
          padding: const EdgeInsets.all(Dimens.d16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.d8),
                      color: colorScheme(context).primaryContainer),
                  height: Dimens.d58,
                  width: Dimens.d58,
                  padding: const EdgeInsets.all(Dimens.d16),
                  child: CachedNetworkImage(
                    imageUrl: exerciseData.icon ?? "",
                    fit: BoxFit.fitHeight,
                    errorWidget:(c,s,d) => const Icon(Icons.image_not_supported),
                  )
              ),
              const Gap(),
              Expanded(
                child: Text(
                  exerciseData.exerciseTitle ?? "-",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyles.body2Text.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const Gap(h: Dimens.d4,),
              Text(
                "${exerciseData.jumlahDone}/${exerciseData.jumlahSoal} Soal",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyles.subTitle.copyWith(color: colorScheme(context).outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
