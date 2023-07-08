import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/app_size.dart';
import 'package:smartup/core/values/enums.dart';

import '../../core/styles/colors.dart';
import '../../core/values/dimens.dart';
import 'gap.dart';

class BottomSheetSelectGender extends StatefulWidget {
  final Gender initGender;
  const BottomSheetSelectGender({super.key, this.initGender = Gender.none});

  @override
  State<BottomSheetSelectGender> createState() => _BottomSheetSelectGenderState();
}

class _BottomSheetSelectGenderState extends State<BottomSheetSelectGender> {
  _BottomSheetSelectGenderState();

  Gender selectGender = Gender.none;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectGender = widget.initGender;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(),
        Container(height: Dimens.d8, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimens.d8), color: themeData(context).dividerColor),),
        const Gap(),
        const Text("Pilih Jenis Kelamin", style: TextStyles.highlightText,),
        const Gap(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              color: selectGender.isMan ? colorScheme(context).primaryContainer : colorScheme(context).surfaceVariant,
              shape: RoundedRectangleBorder(side: selectGender.isMan ? BorderSide(color: colorScheme(context).primary) : BorderSide.none, borderRadius: BorderRadius.circular(Dimens.d16)),
              child: InkWell(
                onTap:() {
                  setState(() {
                    selectGender = Gender.man;
                  });
                  Get.back(result: selectGender);
                } ,
                child: Container(
                  width: AppSize.getWidth(margin: 64)/2,
                  padding: const EdgeInsets.symmetric(vertical: Dimens.d16),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.man_rounded, size: 50,),
                      Gap(),
                      Text("Laki-laki", style: TextStyles.title,)
                    ],
                  ),
                ),
              ),
            ),
            const Gap(w: Dimens.d16),
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              color: selectGender.isWoman ? colorScheme(context).primaryContainer : colorScheme(context).surfaceVariant,
              shape: RoundedRectangleBorder(side: selectGender.isWoman ? BorderSide(color: colorScheme(context).primary) : BorderSide.none, borderRadius: BorderRadius.circular(Dimens.d16)),
              child: InkWell(
                onTap:() {
                  setState(() {
                    selectGender = Gender.woman;
                  });
                  Get.back(result: selectGender);
                } ,
                child: Container(
                  width: AppSize.getWidth(margin: 64)/2,
                  padding: const EdgeInsets.symmetric(vertical: Dimens.d16),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.woman_2_rounded, size: 50,),
                      Gap(),
                      Text("Perempuan", style: TextStyles.title,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        const Gap()
      ],
    );
  }
}
