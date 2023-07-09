import 'package:flutter/material.dart';

import '../../core/styles/colors.dart';
import '../../core/values/dimens.dart';

class IndicatorLoading extends StatelessWidget {
  const IndicatorLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Future(() => false),
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        child: SizedBox(
          height: 100,
          width: 100,
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.d16)),
              color: colorScheme(context).surface,
              child: Container(
                height: 80,
                width: 80,
                padding: const EdgeInsets.all(Dimens.d16),
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
