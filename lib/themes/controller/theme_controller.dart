import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs;

  void changeTheme(ThemeMode mode) {
    themeMode.value = mode;
    log("The theme: ${themeMode.value}");
  }
}
