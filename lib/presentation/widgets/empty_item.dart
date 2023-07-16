import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/presentation/widgets/gap.dart';

class EmptyItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  const EmptyItem({super.key, this.title = "Data tidak ditemukan!", this.subtitle = "", this.image = ImageAssets.imgQuestionMark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.d16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(image, height: 150, fit: BoxFit.fitHeight,),
            const Gap(),
            Text(
              title,
              style: TextStyles.title,
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: TextStyles.subTitle,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
