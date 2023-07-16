import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/app_size.dart';

import '../../core/styles/colors.dart';
import '../../core/values/dimens.dart';
import 'gap.dart';

class BottomSheetAlert extends StatefulWidget {
  final String title;
  final String message;
  final Widget image;
  final Widget? positiveButton;
  final Widget? negativeButton;
  const BottomSheetAlert({super.key, required this.title, required this.message, required this.image, this.positiveButton, this.negativeButton});

  @override
  State<BottomSheetAlert> createState() => _BottomSheetAlertState();
}

class _BottomSheetAlertState extends State<BottomSheetAlert> {
  _BottomSheetAlertState();
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> listButton = [];
    if(widget.negativeButton != null){
      listButton.add(SizedBox(width: AppSize.getWidth(margin: Dimens.d48)/2, child: widget.negativeButton,));
    }
    listButton.addIf(widget.positiveButton != null && widget.negativeButton != null, const Gap(w: Dimens.d16,));
    if(widget.positiveButton != null){
      listButton.add(SizedBox(width: AppSize.getWidth(margin: Dimens.d48)/2, child: widget.positiveButton,));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(),
        Container(height: Dimens.d6, width: 80, decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimens.d8), color: themeData(context).dividerColor),),
        const Gap(h: Dimens.d8,),
        widget.image.marginAll(Dimens.d16),
        const Gap(h: Dimens.d8,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.d16),
          child: Text(widget.title.capitalize ?? "", style: TextStyles.title, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.d16),
          child: Text(widget.message.capitalizeFirst ?? "", style: TextStyles.body2Text, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
        const Gap(),
        widget.positiveButton != null || widget.negativeButton != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.d16),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: listButton,),
        ) : const SizedBox(height: 0,),
        const Gap()
      ],
    );
  }
}
