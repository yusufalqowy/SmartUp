import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/data/course/model/exercise_result.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/route/routes.dart';

class ExerciseResultScreen extends StatefulWidget {
  const ExerciseResultScreen({super.key});

  @override
  State<ExerciseResultScreen> createState() => _ExerciseResultScreenState();
}

class _ExerciseResultScreenState extends State<ExerciseResultScreen> {
  Result result = Get.arguments;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: ()=>Get.offAllNamed(Routes.main), icon: const Icon(Icons.close)), title: const Text("Tutup"), automaticallyImplyLeading: false, backgroundColor: colorScheme(context).primaryContainer,),
      backgroundColor: colorScheme(context).primaryContainer,
      body: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(Dimens.d16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Selamat", style: TextStyles.highlightText,),
            const Text("Kamu telah menyelesaikan Kuiz ini", style: TextStyles.body2Text,),
            const Gap(),
            SvgPicture.asset(ImageAssets.imgResult),
            const Gap(),
            const Text("Nilai kamu:", style: TextStyles.body1Text,),
            Text("${result.jumlahScore}", style: TextStyles.bannerText.copyWith(fontSize: 90),),


          ],
        ),
      ),
    );
  }
}
