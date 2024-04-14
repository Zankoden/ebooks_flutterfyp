import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ebooks/api/api_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePageController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController profilePicController = TextEditingController();

  Rx<Map<String, dynamic>?> userInfo = Rx<Map<String, dynamic>?>(null);
  Rx<File?> profileImageFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      final response = await http.post(
        Uri.parse(APIService.getUserInfo),
        body: {
          'user_id': userId.toString(),
        },
      );

      // print("The edit res: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success']) {
          userInfo.value = data['user_info'];
          firstNameController.text = userInfo.value!['first_name'];
          lastNameController.text = userInfo.value!['last_name'];
          emailController.text = userInfo.value!['email'];
          phoneNumberController.text = userInfo.value!['phone_number'];
          profilePicController.text = userInfo.value!['profile_image_url'];
        } else {
          log('Failed to get user info: ${data['message']}');
        }
      } else {
        log('Failed to get user info');
      }
    }
  }

  Future<void> updateProfile(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String profilePic,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      final response = await http.post(
        Uri.parse(APIService.updateUserInfo),
        body: {
          'user_id': userId.toString(),
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phoneNumber,
          'profile_image_url': profilePic,
        },
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> data = json.decode(response.body);
          if (data['success']) {
            await getUserInfo();
          } else {
            log('Failed to update user info: ${data['message']}');
          }
        } catch (e) {
          log('Error parsing JSON response: $e');
        }
      } else {
        log('Failed to update user info: ${response.reasonPhrase}');
      }

      log("Response Status code: ${response.statusCode}");
    }
  }

  Future<void> pickProfileImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      profileImageFile.value = File(result.files.single.path!);
      update();
    }
  }
}
