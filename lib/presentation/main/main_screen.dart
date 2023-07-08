import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/font_size.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/core/values/texts.dart';
import 'package:smartup/presentation/main/home/home_screen.dart';
import 'package:smartup/presentation/main/profile/profile_screen.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/presentation/widgets/svg_icon.dart';
import 'package:smartup/route/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: controller.navigationIndex.value,
          children: const [HomeScreen(), ProfileScreen()],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              shape: const CircleBorder(),
              child: SvgIconAsset(assetName: ImageAssets.icDiscussion, size: 24, color: colorScheme(context).onSurface,),
              onPressed: (){
                Get.toNamed(Routes.discussion);
              },
            ),
            const Gap(h: Dimens.d4,),
            const Text(Texts.textDiskusiSoal, style: TextStyles.selectedNavigationLabel,)
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) => controller.navigateToIndex(index: index),
          selectedIndex: controller.navigationIndex.value,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: [
            NavigationDestination(
              icon: SvgIconAsset(assetName: ImageAssets.icHomeInActive, color: colorScheme(context).onSurface,),
              label: "Home",
              selectedIcon: SvgIconAsset(assetName: ImageAssets.icHomeActive, color: colorScheme(context).onSurface,),
            ),
            NavigationDestination(
                icon: SvgIconAsset(assetName: ImageAssets.icProfileInActive, color: colorScheme(context).onSurface,),
                label: "Profile",
                selectedIcon: SvgIconAsset(assetName: ImageAssets.icProfileActive, color: colorScheme(context).onSurface,),
            ),
          ],
        ),
      );
    });
  }
}
