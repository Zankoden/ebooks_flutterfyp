import 'package:ebooks/auth/views/login_page.dart';
import 'package:ebooks/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('user_id');

  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  final int? userId;
  const MyApp({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_418c6d3115414a4881762dfbdb81dba1",
        builder: (context, navigatorKey) {
          return GetMaterialApp(
            title: 'Ebooks-Point',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            // home: DashboardScreen(),  /// Main screen
            // home: DashboardScreen(),
            home: userId != null ? DashboardScreen() : LoginPage(),
            initialBinding: BindingsBuilder(() {
              Get.lazyPut(() => ThemeController());
            }),
            builder: (context, child) {
              final themeController = Get.find<ThemeController>();
              return Obx(() {
                final themeMode = themeController.themeMode.value;
                return MaterialApp(
                  title: 'E books',
                  debugShowCheckedModeBanner: false,
                  themeMode: themeMode,
                  theme: ThemeData(
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    useMaterial3: true,
                  ),
                  darkTheme: ThemeData.dark(),
                  home: child,
                );
              });
            },
          );
        });
  }
}

/// Added theme mode change

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs;

  void changeTheme(ThemeMode mode) {
    themeMode.value = mode;
  }
}
