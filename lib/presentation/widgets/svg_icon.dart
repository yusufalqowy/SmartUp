import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconAsset extends StatelessWidget {
  final String assetName;
  final double size;
  final Color? color;
  const SvgIconAsset({super.key, required this.assetName, this.size = 24, this.color});

  @override
  Widget build(BuildContext context) {
    ColorFilter? colorFilter;
    if(color != null){
      colorFilter = ColorFilter.mode(color!, BlendMode.srcIn);
    }
    return SvgPicture.asset(assetName, fit: BoxFit.cover, height: size, width: size, colorFilter: colorFilter,);
  }
}
