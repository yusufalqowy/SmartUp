import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/app_size.dart';
import 'package:smartup/core/utils/theme_service.dart';
import 'package:smartup/core/values/enums.dart';

import '../../core/styles/colors.dart';
import '../../core/values/dimens.dart';
import 'gap.dart';

class BottomSheetSelectDegree extends StatefulWidget {
  final Degree initDegree;
  const BottomSheetSelectDegree({super.key, this.initDegree = Degree.NONE});

  @override
  State<BottomSheetSelectDegree> createState() => _BottomSheetSelectDegreeState();
}

class _BottomSheetSelectDegreeState extends State<BottomSheetSelectDegree> {
  _BottomSheetSelectDegreeState();
  Degree selectedDegree = Degree.NONE;
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedDegree = widget.initDegree;
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
        const Text("Pilih Jenjang Pendidikan", style: TextStyles.highlightText,),
        const Gap(h: Dimens.d8,),
        ...Degree.values.where((element) => element != Degree.NONE).map((degree) =>
            Flexible(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: Dimens.d16, vertical: Dimens.d8),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 0,
                color: selectedDegree == degree ? colorScheme(context).primaryContainer : colorScheme(context).surfaceVariant,
                shape: RoundedRectangleBorder(side: ThemeService().isDarkMode() ? BorderSide(color: colorScheme(context).primary) : BorderSide.none, borderRadius: BorderRadius.circular(Dimens.d16)),
                child: SizedBox(
                  width: double.maxFinite,
                  height: Dimens.d50,
                  child: InkWell(
                      onTap:(){
                        setState(() {
                          selectedDegree = degree;
                        });
                        Get.changeTheme(ThemeData.dark(useMaterial3: true));
                        ThemeService().saveThemeToBox(true);
                        Get.back(result: degree);
                      },
                      child: Center(child: Text(degree.name, style: TextStyles.title,),),
                  ),
                ),
              ),
            )
        ).toList(),
        const Gap(h: Dimens.d8,),
      ],
    );
  }
}
