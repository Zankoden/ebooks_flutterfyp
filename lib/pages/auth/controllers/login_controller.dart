import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ebooks/pages/auth/views/login_page.dart';
import 'package:ebooks/dash_board_screen.dart';
import 'package:http/http.dart' as http;
import 'package:ebooks/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Timer? _sessionTimer;

  Future<void> loginUser() async {
    try {
      const url = APIService.loginURL;
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'username': usernameController.text,
          'password': passwordController.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);

      if (responseData['success']) {
        Get.snackbar("Success", "Logged in Successfully");
        final userId = responseData['user_id'];
        await saveSession(userId);

        _startSessionTimer();

        Get.offAll(() => DashboardScreen());
      } else {
        final errorMessage = responseData['message'];
        if (errorMessage == 'Incorrect password.') {
          Get.snackbar('Error', 'Incorrect password.');
        } else {
          Get.snackbar(
            'Error',
            errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } on SocketException {
      Get.snackbar('Error', 'Please check your internet connection.');
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while logging in.');
    }
  }

  Future<void> saveSession(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log("Before saving: $userId");
    await prefs.setInt('user_id', userId);
    log("After saving: $userId");
  }

  void _startSessionTimer() {
    const sessionDuration = Duration(days: 365);
    _sessionTimer = Timer(sessionDuration, _logoutUser);
  }

  void _logoutUser() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('user_id');
    });

    Get.offAll(() => LoginPage());
  }

  @override
  void onClose() {
    super.onClose();
    _sessionTimer?.cancel();
  }
}
