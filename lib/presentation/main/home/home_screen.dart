import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/app_size.dart';
import 'package:smartup/core/utils/extensions.dart';
import 'package:smartup/core/values/constants.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/core/values/keys.dart';
import 'package:smartup/core/values/texts.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/presentation/widgets/banner_item.dart';
import 'package:smartup/presentation/widgets/course_item.dart';
import 'package:smartup/presentation/widgets/course_skeleton.dart';
import 'package:smartup/presentation/widgets/empty_item.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/presentation/widgets/header_section.dart';
import 'package:smartup/presentation/widgets/skeleton.dart';
import 'package:smartup/route/routes.dart';

import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();
  var storage = Get.find<GetStorage>();
  UserData? _userData;

  @override
  void initState() {
    setState(() {
      _userData = UserData.fromRawJson(storage.read(Keys.userData));
    });
    storage.listenKey(Keys.userData, (value) {
      setState(() {
        _userData = UserData.fromRawJson(storage.read(Keys.userData));
      });
    });
    Future.wait([
      homeController.getCourses(email: _userData?.userEmail ?? "", majorName: Constants.majorName),
      homeController.getEventBanner(limit: 6),
    ]);
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
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
              foregroundImage:
                  CachedNetworkImageProvider(_userData?.userFoto ?? ""),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            _userData = UserData.fromRawJson(storage.read(Keys.userData));
          });
          return Future.wait([
            homeController.getCourses(email: _userData?.userEmail ?? "", majorName: Constants.majorName),
            homeController.getEventBanner(limit: 6),
          ]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: Dimens.d16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.d16),
                  decoration: BoxDecoration(
                      color: colorScheme(context).primaryContainer,
                      borderRadius: BorderRadius.circular(Dimens.d16)),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: AppSize.getWidth(margin: 48) / 2,
                        padding: const EdgeInsets.only(left: Dimens.d16),
                        child: const Text(
                          Texts.textHomeBanner,
                          style: TextStyles.bannerText,
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: SvgPicture.asset(
                            ImageAssets.imgHomeBanner,
                            fit: BoxFit.fitWidth,
                            width: AppSize.getWidth(margin: 16) / 2,
                          ))
                    ],
                  )),
              HeaderSection(
                title: "Pilih Pelajaran",
                margin: const EdgeInsets.all(Dimens.d16),
                isShowMore: true,
                onTap: () => Get.toNamed(Routes.course),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Dimens.d16),
                child: GetBuilder<HomeController>(builder: (controller) {
                  if (controller.courseResponseState.value.status.isSuccess) {
                    var courses = controller.courseResponseState.value.data?.where((element) => element.courseName!.length > 3).toList();
                    if(!courses.isNullOrEmpty){
                      return ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var courseData = courses[index];
                            return CourseItem(courseData: courseData,);
                          },
                          separatorBuilder: (context, index) {
                            return const Gap(
                              h: Dimens.d8,
                            );
                          },
                          itemCount: courses!.length >= 4 ? 4 : courses.length
                      );
                    }else{
                      return const EmptyItem();
                    }

                  } else if(controller.courseResponseState.value.status.isError){
                    return Container(
                      margin: const EdgeInsets.all(Dimens.d16),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Gagal memuat data",
                              style: TextStyles.body2Text,
                            ),
                            TextButton.icon(
                              onPressed: () => controller.getCourses(email: _userData?.userEmail ?? ""),
                              icon: const Icon(Icons.refresh),
                              label: const Text("Refresh"),
                            )
                          ],
                        ),
                      ),
                    );
                  }else{
                    return ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const CourseSkeleton();
                        },
                        separatorBuilder: (context, index) {
                          return const Gap(
                            h: Dimens.d8,
                          );
                        },
                        itemCount: 4);
                  }
                }),
              ),
              const HeaderSection(
                title: "Terbaru",
                margin: EdgeInsets.all(Dimens.d16),
              ),
              GetBuilder<HomeController>(builder: (controller) {
                if (controller.bannerResponseState.value.status.isSuccess) {
                  var banners = controller.bannerResponseState.value.data;
                  if (!banners.isNullOrEmpty) {
                    return CarouselSlider(
                        items: List.generate(banners!.length, (index) {
                          var banner = banners[index];
                          var margin =
                              const EdgeInsets.symmetric(horizontal: Dimens.d8);
                          if (index == 0) {
                            margin = const EdgeInsets.only(right: Dimens.d8);
                          }
                          if (index == banners.length - 1) {
                            margin = const EdgeInsets.only(left: Dimens.d8);
                          }
                          return BannerItem(
                            banner: banner,
                            margin: margin,
                          );
                        }),
                        options: CarouselOptions(
                            enableInfiniteScroll: false,
                            viewportFraction: 0.9,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            enlargeFactor: 1,
                            height: 150));
                  } else {
                    return const EmptyItem();
                  }
                } else if (controller.bannerResponseState.value.status.isError) {
                  return Container(
                    margin: const EdgeInsets.all(Dimens.d16),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Gagal memuat data",
                            style: TextStyles.body2Text,
                          ),
                          TextButton.icon(
                            onPressed: () =>
                                controller.getEventBanner(limit: 3),
                            icon: const Icon(Icons.refresh),
                            label: const Text("Refresh"),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return CarouselSlider(
                      items: List.generate(3, (index) {
                        var margin =
                            const EdgeInsets.symmetric(horizontal: Dimens.d8);
                        if (index == 0) {
                          margin = const EdgeInsets.only(right: Dimens.d8);
                        }
                        if (index == 2) {
                          margin = const EdgeInsets.only(left: Dimens.d8);
                        }
                        return Container(
                            margin: margin,
                            child: const Skeleton(
                              height: 150,
                              cornerRadius: Dimens.d16,
                            ));
                      }),
                      options: CarouselOptions(
                          enableInfiniteScroll: false,
                          viewportFraction: 0.9,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          enlargeFactor: 1,
                          height: 150));
                }
              }),
              const Gap(
                h: Dimens.d32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
