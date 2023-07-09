import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/dialog.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/core/values/texts.dart';
import 'package:smartup/presentation/auth/login/login_controller.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/presentation/widgets/indicator_loading.dart';
import 'package:smartup/route/routes.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          Texts.textLogin,
          style: TextStyles.highlightText.copyWith(fontWeight: FontWeight.bold),
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
                      // LoadingDialog.showLoading();
                      await controller.onGoogleSignIn();
                      // await controller.signOut();
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
  }
}
