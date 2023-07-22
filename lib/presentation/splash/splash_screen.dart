import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/colors.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/core/values/keys.dart';
import 'package:smartup/route/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 5000));
    if (context.mounted) {
      String? userData = Get.find<GetStorage>().read(Keys.userData);
      if(userData != null && userData.isNotEmpty){
        Get.offAllNamed(Routes.main);
      }else{
        Get.offAllNamed(Routes.login);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset(ImageAssets.icLogoSmartUp, width: 150, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(margin:const EdgeInsets.only(bottom: Dimens.d16), child: const Text("sup.id", style: TextStyles.subTitle,))
          )
        ],
      ),
    );
  }
}
