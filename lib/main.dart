import 'dart:io';

import 'package:alice/alice.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartup/core/utils/theme_service.dart';
import 'package:smartup/core/values/colors.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';
import 'package:smartup/route/pages.dart';
import 'package:smartup/route/routes.dart';
import 'core/utils/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final _defaultLightColorScheme = ThemeData.light(useMaterial3: false).colorScheme.copyWith(primary: AppColors.primary, secondary: AppColors.secondary,);
  static  final _defaultDarkColorScheme = ThemeData.light(useMaterial3: false).colorScheme.copyWith(primary: AppColors.primary, secondary: AppColors.secondary,);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var alice = Get.put(Alice());
    Get.put(GetStorage(), permanent: true);
    Get.put<FirebaseAuthService>(FirebaseAuthServiceImpl(), permanent: true);

    return DynamicColorBuilder(
        builder: (lightColorScheme, darkColorScheme){
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
            child: GetMaterialApp(
              title: 'Smart Up',
              navigatorKey: alice.getNavigatorKey(),
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
              debugShowCheckedModeBanner: false,
              themeMode: ThemeService().theme,
              initialRoute: Routes.splash,
              getPages: Pages.pages,
            ),
          );
        }
    );
  }
}

/// To handle Error: HandshakeException: Handshake error in client (OS Error: CERTIFICATE_VERIFY_FAILED: certificate has expired(handshake.cc:393))
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
