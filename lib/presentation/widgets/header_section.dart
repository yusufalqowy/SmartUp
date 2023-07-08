import 'package:flutter/material.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/texts.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  final bool isShowMore;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const HeaderSection(
      {super.key, required this.title, this.margin = EdgeInsets.zero, this.isShowMore = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            title,
            style: TextStyles.headerSection,
          )),
          if (isShowMore)
            InkWell(
              onTap: onTap,
              child: Text(
                Texts.textLihatSemua,
                style: TextStyles.linkText
                    .copyWith(color: colorScheme(context).primary),
              ),
            ),
        ],
      ),
    );
  }
}
