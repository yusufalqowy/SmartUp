import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartup/core/utils/theme_service.dart';
import 'package:smartup/route/pages.dart';
import 'package:smartup/route/routes.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final _defaultLightColorScheme = ThemeData.light(useMaterial3: false).colorScheme.copyWith(primary: const Color(0xFF357AD4), secondary: const Color(0xFF27B1E0), );
  static  final _defaultDarkColorScheme = ThemeData.dark(useMaterial3: false).colorScheme;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (lightColorScheme, darkColorScheme){
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
            child: GetMaterialApp(
              title: 'Smart Up',
              theme: ThemeData(
                colorScheme: lightColorScheme ?? _defaultLightColorScheme,
                fontFamily: "Rubik",
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
                fontFamily: "Rubik",
                useMaterial3: true,
              ),
              themeMode: ThemeService().theme,
              initialRoute: Routes.login,
              getPages: Pages.pages,
            ),
          );
        }
    );

  }
}
