import 'package:flutter/material.dart';
import 'package:smartup/core/values/dimens.dart';

class Gap extends StatelessWidget {
  final double h;
  final double w;
  const Gap({super.key, this.h = Dimens.d16, this.w = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: h, width: w,);
  }
}
