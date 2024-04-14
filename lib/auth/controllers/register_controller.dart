import 'package:ebooks/api/api_services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  var userType = 'Normal'.obs; // Default user type is 'Normal'

  Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    required String userType, // Changed from bool to String
  }) async {
    const String url = APIService.registerURL;

    final response = await http.post(
      Uri.parse(url),
      body: {
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
        'type': userType, // Changed from 'is_author' to 'type'
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }
}