import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartup/core/styles/colors.dart';

class Skeleton extends StatelessWidget {
  final double height;
  final double width;
  final double cornerRadius;
  final EdgeInsetsGeometry margin;
  final BoxShape? shape;
  const Skeleton({super.key, this.height = 16, this.width = double.maxFinite, this.cornerRadius = 8, this.margin = EdgeInsets.zero, this.shape});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorScheme(context).outline.withOpacity(0.5),
      highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      child: Container(
          height: height,
          width: width,
          margin: margin,
          decoration: BoxDecoration(
            color: colorScheme(context).outline.withOpacity(0.5),
            borderRadius: shape != null ? null : BorderRadius.all(Radius.circular(cornerRadius)),
            shape: shape != null ? shape! : BoxShape.rectangle,
          )
      ),
    );
  }
}
