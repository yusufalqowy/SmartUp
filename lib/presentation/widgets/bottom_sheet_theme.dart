import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/app_size.dart';
import 'package:smartup/core/utils/theme_service.dart';
import 'package:smartup/core/values/dimens.dart';

import 'gap.dart';

class BottomSheetSelectTheme extends StatefulWidget {
  const BottomSheetSelectTheme({super.key});

  @override
  State<BottomSheetSelectTheme> createState() => _BottomSheetSelectThemeState();
}

class _BottomSheetSelectThemeState extends State<BottomSheetSelectTheme> {
  _BottomSheetSelectThemeState();
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(),
        Container(height: Dimens.d6, width: 80, decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimens.d8), color: themeData(context).dividerColor),),
        const Gap(),
        const Text("Pilih Tema", style: TextStyles.highlightText,),
        const Gap(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              color: ThemeService().isDarkMode() ? colorScheme(context).primaryContainer : colorScheme(context).surfaceVariant,
              shape: RoundedRectangleBorder(side: ThemeService().isDarkMode() ? BorderSide(color: colorScheme(context).primary) : BorderSide.none, borderRadius: BorderRadius.circular(Dimens.d16)),
              child: InkWell(
                onTap:(){
                  Get.changeTheme(ThemeData.dark(useMaterial3: true));
                  ThemeService().saveThemeToBox(true);
                  Get.back();
                } ,
                child: Container(
                  width: AppSize.getWidth(margin: 64)/2,
                  padding: const EdgeInsets.symmetric(vertical: Dimens.d16),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.dark_mode, size: 50,),
                      Gap(),
                      Text("Dark Mode", style: TextStyles.title,)
                    ],
                  ),
                ),
              ),
            ),
            const Gap(w: Dimens.d16),
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              color: !ThemeService().isDarkMode() ? colorScheme(context).primaryContainer : colorScheme(context).surfaceVariant,
              shape: RoundedRectangleBorder(side: !ThemeService().isDarkMode() ? BorderSide(color: colorScheme(context).primary) : BorderSide.none, borderRadius: BorderRadius.circular(Dimens.d16)),
              child: InkWell(
                onTap:() {
                  Get.changeTheme(ThemeData.light(useMaterial3: true));
                  ThemeService().saveThemeToBox(false);
                  Get.back();
                } ,
                child: Container(
                  width: AppSize.getWidth(margin: 64)/2,
                  padding: const EdgeInsets.symmetric(vertical: Dimens.d16),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.light_mode, size: 50,),
                      Gap(),
                      Text("Light Mode", style: TextStyles.title,)
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
