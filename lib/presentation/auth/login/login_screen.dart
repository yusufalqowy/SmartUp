import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/dialog.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/core/values/keys.dart';
import 'package:smartup/core/values/texts.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/presentation/auth/login/login_controller.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_alert.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/route/routes.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});
  GetStorage storage = Get.find();

  void handleResponse(LoginController ctrl, BuildContext context) {
    var userResponse = ctrl.login.value;
    switch (userResponse.status) {
      case NetworkStatus.loading:
        LoadingDialog.showLoading();
        break;
      case NetworkStatus.success:
        LoadingDialog.dismissLoading();
        if (userResponse.data?.iduser != "0") {
          userResponse.data?.encodeToJson();
          storage.write(Keys.userData, userResponse.data?.encodeToJson());
          // User is Registered
          Get.offAllNamed(Routes.main);
        } else {
          // User is Signed In & Is not Registered
          Get.bottomSheet(
              BottomSheetAlert(
                title: "Informasi",
                message:
                "Maaf kami tidak menemukan akun Anda, sepertinya Anda belum terdaftar. Daftar sekarang?",
                image: SvgPicture.asset(
                  ImageAssets.imgRegister,
                  fit: BoxFit.fitHeight,
                  height: 150,
                ),
                positiveButton: FilledButton(
                    onPressed: () {
                      Get.back();
                      Get.toNamed(Routes.register, arguments: ctrl.userEmail.value);
                    },
                    child: const Text("Ya")),
                negativeButton: FilledButton.tonal(
                  onPressed: () {
                    Get.back();
                    controller.logOut(isGotoLogin: false);
                  },
                  child: const Text("Tidak"),
                ),
              ),
              backgroundColor: colorScheme(context).surface);
        }
        break;
      case NetworkStatus.error:
        LoadingDialog.dismissLoading();
        Get.bottomSheet(
            BottomSheetAlert(
              title: "Error",
              message: userResponse.message ?? "Unknown Error",
              image: SvgPicture.asset(
                ImageAssets.imgSorry,
                fit: BoxFit.fitHeight,
                height: 150,
              ),
              negativeButton: FilledButton.tonal(
                onPressed: () {
                  Get.back();
                  controller.logOut(isGotoLogin: false);
                },
                child: const Text("Tutup"),
              ),
            ),
            backgroundColor: colorScheme(context).surface);
        break;
      default:
        LoadingDialog.dismissLoading();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      assignId: true,
      builder: (controller) {
        Future.delayed(Duration.zero,()=>handleResponse(controller, context));
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              Texts.textLogin,
              style: TextStyles.highlightText.copyWith(
                  fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.d16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.imgLoginBanner,
                    ),
                    const Gap(),
                    const Text(
                      Texts.textSelamatDatang,
                      style: TextStyles.highlightText,
                    ),
                    const Gap(
                      h: Dimens.d8,
                    ),
                    const Text(
                      Texts.textDescSelamatDatang,
                      style: TextStyles.subTitle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    SignInButton(
                        buttonType: ButtonType.googleDark,
                        onPressed: () async {
                          await controller.onGoogleSignIn();
                        },
                        btnText: Texts.textBtnMasukDenganGoogle,
                        width: double.maxFinite,
                        padding: Dimens.d16),
                    const Gap(),
                    SignInButton(
                        buttonType: ButtonType.appleDark,
                        onPressed: () {
                          Get.toNamed(Routes.register);
                        },
                        btnText: Texts.textBtnMasukDenganApple,
                        width: double.maxFinite,
                        padding: Dimens.d16),
                    const Gap(
                      h: Dimens.d48,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
