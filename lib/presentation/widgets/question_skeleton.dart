import 'package:flutter/material.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/presentation/widgets/skeleton.dart';

class QuestionSkeleton extends StatelessWidget {
  const QuestionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Skeleton(height: Dimens.d20, width: 100,),
      Gap(),
      Skeleton(height: 300,),
      Gap(),
      Skeleton(height: 50,),
      Gap(),
      Skeleton(height: 50,),
      Gap(),
      Skeleton(height: 50,),
      Gap(),
      Skeleton(height: 50,),
      Gap(),
      Skeleton(height: 50,),
    ]);
  }
}
