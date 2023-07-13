import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/app_size.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/core/values/keys.dart';
import 'package:smartup/core/values/texts.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/presentation/widgets/course_item.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/presentation/widgets/header_section.dart';
import 'package:smartup/presentation/widgets/svg_icon.dart';

import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var storage = Get.find<GetStorage>();
  UserData? _userData;
  @override
  void initState() {
    setState(() {
      _userData = UserData.fromRawJson(storage.read(Keys.userData));
    });
    storage.listenKey(Keys.userData, (value) {
      _userData = UserData.fromRawJson(storage.read(Keys.userData));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, ${_userData?.userName}",
              style: TextStyles.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const Text(
              Texts.textSelamatDatang,
              style: TextStyles.subTitle,
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: Dimens.d16),
            child: CircleAvatar(
              foregroundImage: CachedNetworkImageProvider(_userData?.userFoto??""),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: Dimens.d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: Dimens.d16),
                decoration: BoxDecoration(
                    color: colorScheme(context).primaryContainer,
                    borderRadius: BorderRadius.circular(Dimens.d16)
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      width: AppSize.getWidth(margin: 48) / 2,
                      padding: const EdgeInsets.only(left: Dimens.d16),
                      child: const Text(
                        Texts.textHomeBanner, style: TextStyles.bannerText,),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: SvgPicture.asset(
                          ImageAssets.imgHomeBanner, fit: BoxFit.fitWidth,
                          width: AppSize.getWidth(margin: 16) / 2,)
                    )
                  ],
                )
            ),
            const HeaderSection(title: "Pilih Pelajaran", margin: EdgeInsets.all(Dimens.d16), isShowMore: true,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Dimens.d16),
              child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return const CourseItem();
                  },
                  separatorBuilder: (context, index){
                    return const Gap(h: Dimens.d8,);
                  },
                  itemCount: 5
              ),
            ),
            const HeaderSection(title: "Terbaru", margin: EdgeInsets.all(Dimens.d16),),
            CarouselSlider(
                items: List.generate(6, (index){
                  var margin = const EdgeInsets.symmetric(horizontal: Dimens.d8);
                  if(index == 0){
                    margin = const EdgeInsets.only(right: Dimens.d8);
                  }
                  if(index == 5){
                    margin = const EdgeInsets.only(left: Dimens.d8);
                  }
                  return Container(
                    width: AppSize.getWidth(),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimens.d16), image: const DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1504805572947-34fad45aed93?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",), fit: BoxFit.cover)),
                    height: 150,
                    margin: margin,
                  );
                }),
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 0.9,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    enlargeFactor: 1,
                    height: 150
                )
            )
          ],
        ),
      ),
    );
  }
}
