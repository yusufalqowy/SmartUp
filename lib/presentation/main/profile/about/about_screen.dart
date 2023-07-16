import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/functions.dart';
import 'package:smartup/core/values/dimens.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tentang Aplikasi"),
        backgroundColor: colorScheme(context).primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dimens.d16),
        child: Column(
          children: [
            HtmlWidget(
             '''
             <p>Aplikasi <b>Smart Up</b> merupakan aplikasi yang dibuat dengan Flutter dan untuk memenuhi final project Bootcamp Flutter Edspert.id.</p>
             <p>Ilustrasi didalam aplikasi ini bersumber dari Storyset by freepik. Kunjungi <a href="https://storyset.com/">storyset.com</a>.</p>
             <p>Developed by<br />Muhammad Yusuf Alqowy</p>
             <p><a href="https://www.linkedin.com/in/yusufalqowy/">LinkedIn</a> <a href="https://github.com/yusufalqowy">Github</a> <a href="https://dribbble.com/yusufalqowy">Dribbble</a>&nbsp;<a href="https://www.instagram.com/yusufalqowy/">Instagram</a>&nbsp;</p>
             ''',
              onTapUrl: (url){ return openLinkAsync(link: url); },
              textStyle: TextStyles.body2Text.copyWith(fontFamily: 'rubik'),
            )
          ],
        ),
      ),
    );
  }
}
