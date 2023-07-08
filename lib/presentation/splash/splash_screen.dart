import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smartup/core/values/colors.dart';
import 'package:smartup/core/values/images.dart';
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
      Get.offAllNamed(Routes.login);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: Center(
        child: SvgPicture.asset(ImageAssets.icLogoSmartUp, width: 150, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
      ),
    );
  }
}
