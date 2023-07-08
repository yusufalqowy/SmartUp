import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/presentation/splash/splash_controller.dart';
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
      Get.offAllNamed(Routes.main);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(Dimens.d16),
        child: Center(
          child: Column(
            children: [
              const Text("Smart Up"),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("sup.id", style: TextStyle(color: Colors.grey, fontSize: 10)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
