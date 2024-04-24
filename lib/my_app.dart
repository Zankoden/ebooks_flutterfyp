import 'package:ebooks/splash_screen/views/splash_screen_page.dart';
import 'package:ebooks/themes/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class MyApp extends StatelessWidget {
  final ThemeController themeController;

  const MyApp({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: "test_public_key_418c6d3115414a4881762dfbdb81dba1",
      builder: (context, navigatorKey) {
        return Obx(
          () {
            final themeMode = themeController.themeMode.value;
            return GetMaterialApp(
              title: 'Ebooks-Point',
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              darkTheme: ThemeData.dark(),
              navigatorKey: navigatorKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              home: SplashScreenPage(),
            );
          },
        );
      },
    );
  }
}
