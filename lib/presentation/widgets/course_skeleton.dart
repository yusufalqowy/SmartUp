import 'package:flutter/material.dart';
import 'package:smartup/core/utils/app_size.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/presentation/widgets/skeleton.dart';

class CourseSkeleton extends StatelessWidget {
  const CourseSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.d16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Skeleton(width: Dimens.d58, height: Dimens.d58,),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: Dimens.d8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Skeleton(height: Dimens.d20, width: AppSize.getWidth()/4,),
                      const Gap(h: Dimens.d4,),
                      Skeleton(height: Dimens.d8, width: AppSize.getWidth()/2.5,),
                      const Gap(h: Dimens.d8,),
                      const Skeleton(height: Dimens.d8,),
                    ],
                  ),
                ),
              )
            ],
          ),
      )
    );
  }
}
