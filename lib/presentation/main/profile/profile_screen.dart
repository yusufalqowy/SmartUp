import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/core/values/keys.dart';
import 'package:smartup/core/values/texts.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/presentation/main/profile/profile_controller.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_alert.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_theme.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/route/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var storage = Get.find<GetStorage>();
  UserData? _userData;
  ProfileController controller = Get.find();

  @override
  void initState() {
    setState(() {
      _userData = UserData.fromRawJson(storage.read(Keys.userData));
    });
    storage.listenKey(Keys.userData, (value) {
      setState(() {
        _userData = UserData.fromRawJson(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(Texts.textAkunSaya),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimens.d16),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.d16)),
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
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: CachedNetworkImageProvider(
                              _userData?.userFoto ?? ""),
                        ),
                        Positioned(
                          top: 90,
                          child: IconButton(
                              onPressed: () async {
                                await Get.toNamed(Routes.editProfile);
                                _userData = UserData.fromRawJson(storage.read(Keys.userData));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      colorScheme(context).primary),
                                  shape: const MaterialStatePropertyAll(
                                      CircleBorder()),
                                  elevation: const MaterialStatePropertyAll(8)),
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.edit,
                                color: colorScheme(context).surface,
                              )),
                        )
                      ],
                    ),
                    const Gap(h: Dimens.d32,),
                    Text(
                      _userData?.userName ?? "",
                      style: TextStyles.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(_userData?.userEmail ?? "",
                        style: TextStyles.subTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
            const Gap(),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.d16)),
              child: Padding(
                padding: const EdgeInsets.all(Dimens.d16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: colorScheme(context).primary,
                        ),
                        const Gap(
                          w: Dimens.d16,
                        ),
                        Expanded(
                          child: Text(_userData?.userName ?? "",
                              style: TextStyles.body2Text
                                  .copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    const Gap(),
                    Row(
                      children: [
                        Icon(
                          Icons.mail_outline,
                          color: colorScheme(context).primary,
                        ),
                        const Gap(
                          w: Dimens.d16,
                        ),
                        Text(
                          _userData?.userEmail ?? "",
                          style: TextStyles.body2Text
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Gap(),
                    Row(
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          color: colorScheme(context).primary,
                        ),
                        const Gap(
                          w: Dimens.d16,
                        ),
                        Text(
                          _userData?.userGender ?? "",
                          style: TextStyles.body2Text
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Gap(),
                    Row(
                      children: [
                        Icon(
                          Icons.class_outlined,
                          color: colorScheme(context).primary,
                        ),
                        const Gap(
                          w: Dimens.d16,
                        ),
                        Text(
                          _userData?.kelas ?? "",
                          style: TextStyles.body2Text
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Gap(),
                    Row(
                      children: [
                        Icon(
                          Icons.school_outlined,
                          color: colorScheme(context).primary,
                        ),
                        const Gap(
                          w: Dimens.d16,
                        ),
                        Text(
                          _userData?.userAsalSekolah ?? "",
                          style: TextStyles.body2Text
                              .copyWith(fontWeight: FontWeight.bold),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.d16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                onTap: () {
                  Get.bottomSheet(const BottomSheetSelectTheme(),
                      backgroundColor: colorScheme(context).surface);
                },
                child: Container(
                  padding: const EdgeInsets.all(Dimens.d16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.theater_comedy_outlined,
                        color: colorScheme(context).primary,
                      ),
                      const Gap(
                        w: Dimens.d16,
                      ),
                      Text(
                        Texts.textTema,
                        style: TextStyles.body2Text
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Gap(),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.d16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                onTap: () => Get.toNamed(Routes.aboutApp),
                child: Container(
                  padding: const EdgeInsets.all(Dimens.d16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: colorScheme(context).primary,
                      ),
                      const Gap(
                        w: Dimens.d16,
                      ),
                      Text(
                        "Tentang Aplikasi",
                        style: TextStyles.body2Text
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Gap(),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.d16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                onTap: () => logout(),
                child: Container(
                  padding: const EdgeInsets.all(Dimens.d16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                      const Gap(
                        w: Dimens.d16,
                      ),
                      Text(
                        Texts.textLogout,
                        style: TextStyles.body2Text
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Gap(h: Dimens.d32,)
          ],
        ),
      ),
    );
  }

  logout() async {
    Get.bottomSheet(
        BottomSheetAlert(
          title: "Apakah anda ingin keluar?",
          image: SvgPicture.asset(ImageAssets.imgQuestionMark,
            fit: BoxFit.fitHeight,
            height: 150,
          ),
          negativeButton: FilledButton.tonal(
            onPressed: () {
              Get.back();
            },
            child: const Text("Tidak"),
          ),
          positiveButton: FilledButton(
            onPressed: () async {
              storage.erase();
              await controller.logOut(isGotoLogin: true);
            },
            child: const Text("Iya"),
          ),
        )
    , backgroundColor: colorScheme(context).surface);
  }
}
