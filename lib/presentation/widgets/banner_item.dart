import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartup/core/utils/app_size.dart';
import 'package:smartup/core/utils/functions.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/data/banner/model/banner_response.dart';

class BannerItem extends StatelessWidget {
  final BannerData banner;
  final EdgeInsets margin;
  final double radius;

  const BannerItem(
      {super.key,
      required this.banner,
      this.margin = EdgeInsets.zero,
      this.radius = Dimens.d16});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.getWidth(),
      margin: margin,
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.zero,
          child: Ink.image(
            image: CachedNetworkImageProvider(banner.eventImage ?? ""),
            height: 150,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: openLink(link: banner.eventUrl),
            ),
          )),
    );
  }
}
