import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_theme.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/route/routes.dart';

import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Akun Saya"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimens.d16),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.d16)),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(Dimens.d16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person),
                        ),
                        Positioned(
                          top: 70,
                          child: IconButton(
                              onPressed: () { Get.toNamed(Routes.editProfile);},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(themeData(context).primaryColorDark),
                                  shape: const MaterialStatePropertyAll(CircleBorder())),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                    const Gap(),
                    const Text(
                      "Muhammad Yusuf A",
                      style: TextStyles.title,
                    ),
                    const Text(
                      "081542181110",
                      style: TextStyles.subTitle,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.d16)),
              child: Padding(
                padding: const EdgeInsets.all(Dimens.d16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_outline, color: colorScheme(context).primary,),
                        const Gap(
                          w: Dimens.d16,
                        ),
                        Text(
                          "Muhammad Yusuf A",
                          style: TextStyles.body2Text.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Gap(),
                    Row(
                      children: [
                        Icon(Icons.mail_outline, color: colorScheme(context).primary,),
                        const Gap(
                          w: Dimens.d16,
                        ),
                        Text(
                          "yusufaqwya123@gmail.com",
                          style: TextStyles.body2Text.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Gap(),
                    Row(
                      children: [
                        Icon(Icons.people_alt_outlined, color: colorScheme(context).primary,),
                        const Gap(
                          w: Dimens.d16,
                        ),
                        Text(
                          "Laki-laki",
                          style: TextStyles.body2Text.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Gap(),
                    Row(
                      children: [
                        Icon(Icons.class_outlined, color: colorScheme(context).primary,),
                        const Gap(
                          w: Dimens.d16,
                        ),
                        Text(
                          "XI",
                          style: TextStyles.body2Text.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Gap(),
                    Row(
                      children: [
                        Icon(Icons.school_outlined, color: colorScheme(context).primary,),
                        const Gap(
                          w: Dimens.d16,
                        ),
                        Text(
                          "SMA N 1",
                          style: TextStyles.body2Text.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Gap(),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.d16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                onTap: (){Get.bottomSheet(const BottomSheetSelectTheme(), backgroundColor: colorScheme(context).surface);},
                child: Container(
                  padding: const EdgeInsets.all(Dimens.d16),
                  child: Row(
                    children: [
                      Icon(Icons.theater_comedy_outlined, color: colorScheme(context).primary,),
                      const Gap(w: Dimens.d16,),
                      Text("Theme", style: TextStyles.body2Text.copyWith(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            const Gap(),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.d16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                onTap: (){Get.offNamed(Routes.login);},
                child: Container(
                  padding: const EdgeInsets.all(Dimens.d16),
                  child: Row(
                    children: [
                      const Icon(Icons.logout_outlined, color: Colors.red,),
                      const Gap(w: Dimens.d16,),
                      Text("Logout", style: TextStyles.body2Text.copyWith(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
