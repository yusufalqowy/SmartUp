import 'package:flutter/material.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/presentation/widgets/skeleton.dart';

class ExerciseSkeleton extends StatelessWidget {
  const ExerciseSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.d8)),
      child: Container(
        padding: const EdgeInsets.all(Dimens.d16),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton(width: Dimens.d58, height: Dimens.d58,),
            Gap(),
            Skeleton(height: Dimens.d20,),
            Gap(h: Dimens.d4,),
            Skeleton(height: Dimens.d12,),
          ],
        ),
      ),
    );
  }
}
