import 'dart:convert';
import 'package:ebooks/api/api_services.dart';
import 'package:ebooks/pages/profile/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  Future<void> changePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      final currentPassword = currentPasswordController.text;
      final newPassword = newPasswordController.text;
      final confirmNewPassword = confirmNewPasswordController.text;

      // Validate new password and confirm new password
      if (newPassword != confirmNewPassword) {
        Get.snackbar("Error", "New passwords do not match");
        return;
      }

      const url = APIService.changePasswordURL;
      final response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId.toString(),
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          Get.snackbar("Success", data['message']);
          // Clear the text fields
          currentPasswordController.clear();
          newPasswordController.clear();
          confirmNewPasswordController.clear();
          Get.offAll(() => const SettingsPage());
        } else {
          Get.snackbar("Error", data['message']);
        }
      } else {
        Get.snackbar("Error", "Failed to change password");
      }
    }
  }
}
