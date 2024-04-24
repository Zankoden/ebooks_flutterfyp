import 'package:ebooks/my_app.dart';
import 'package:ebooks/themes/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  MobileAds.instance.initialize();
  ThemeController themeController = Get.put(ThemeController());
  runApp(MyApp(themeController: themeController));
}
