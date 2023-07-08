import 'package:flutter/material.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
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
                padding: const EdgeInsets.all(Dimens.d8),
                child: const Icon(Icons.medical_information)),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: Dimens.d8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const Text(
                  "Kimia",
                  style: TextStyles.title,
                ),
                Text(
                  "0/50 Paket latihan soal",
                  style: TextStyles.subTitle.copyWith(color: colorScheme(context).outline),
                ),
                Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    margin: const EdgeInsets.only(top: Dimens.d4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.d4)),
                    child: LinearProgressIndicator(
                      value: 0.3,
                      minHeight: Dimens.d8,
                      backgroundColor: colorScheme(context).outlineVariant,
                      valueColor: AlwaysStoppedAnimation(colorScheme(context).primary),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
