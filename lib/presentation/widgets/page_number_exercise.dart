import 'package:flutter/material.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';

enum PageNumberStatus{
  active, answered, unAnswered;
}

class PageNumberExercise extends StatelessWidget {
  final PageNumberStatus status;
  final int index;
  final Function(int index) onTap;
  const PageNumberExercise({super.key, this.status = PageNumberStatus.unAnswered, required this.index, required this.onTap});

  Color getBackgroundColor(BuildContext context, PageNumberStatus status){
    if(status == PageNumberStatus.unAnswered){
      return colorScheme(context).surface;
    }else if(status == PageNumberStatus.answered){
      return colorScheme(context).primaryContainer;
    }else{
      return colorScheme(context).primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: CircleBorder(side: status == PageNumberStatus.unAnswered ? BorderSide(color: colorScheme(context).primary, width: 1.5) : BorderSide.none),
      color: getBackgroundColor(context, status),
      margin: const EdgeInsets.symmetric(horizontal: Dimens.d4),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => onTap.call(index),
        child: Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.all(Dimens.d8),
          child: Center(child: Text("${index+1}", style: TextStyles.title.copyWith(color: status == PageNumberStatus.unAnswered || status == PageNumberStatus.answered ? colorScheme(context).onSurfaceVariant : colorScheme(context).surfaceVariant),)),
        ),
      ),
    );
  }
}
