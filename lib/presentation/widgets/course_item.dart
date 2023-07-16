import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/data/course/model/course_response.dart';
import 'package:smartup/presentation/exercise/exercise_list/exercise_screen.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/route/routes.dart';

class CourseItem extends StatelessWidget {
  final CourseData courseData;

  const CourseItem({super.key, required this.courseData});

  @override
  Widget build(BuildContext context) {
    double progress = 0;
    if (courseData.jumlahDone != null && courseData.jumlahMateri != null && courseData.jumlahMateri! > 0) {
      progress = courseData.jumlahDone! / courseData.jumlahMateri!;
    }
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => Get.toNamed(Routes.exercise, arguments: ExerciseArgs(courseId: courseData.courseId ?? "", courseName: courseData.courseName ?? "")),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.d16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.d8),
                      color: colorScheme(context).primaryContainer),
                  height: Dimens.d58,
                  width: Dimens.d58,
                  padding: const EdgeInsets.all(Dimens.d16),
                  child: CachedNetworkImage(
                    imageUrl: courseData.urlCover ?? "",
                    fit: BoxFit.fitHeight,
                    errorWidget:(c,s,d) => const Icon(Icons.image_not_supported),
                  )),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: Dimens.d8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        courseData.courseName ?? "-",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyles.title,
                      ),
                      Text(
                        "${courseData.jumlahDone}/${courseData.jumlahMateri} Paket Latihan Soal",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyles.subTitle
                            .copyWith(color: colorScheme(context).outline),
                      ),
                      const Gap(
                        h: Dimens.d4,
                      ),
                      Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 0,
                          margin: const EdgeInsets.only(top: Dimens.d4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dimens.d4)),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: Dimens.d8,
                            backgroundColor: colorScheme(context).outlineVariant,
                            valueColor: AlwaysStoppedAnimation(
                                colorScheme(context).primary),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
