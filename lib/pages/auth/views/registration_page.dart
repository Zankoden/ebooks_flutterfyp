import 'package:ebooks/pages/auth/controllers/register_controller.dart';
import 'package:ebooks/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_page.dart';

class RegistrationPage extends StatelessWidget {
  final RegistrationController _registrationController =
      Get.put(RegistrationController());

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ZText.zCreateAccount,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: ZText.zFirstName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: ZText.zLastName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: ZText.zUsername,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: ZText.zEmail,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: ZText.zPhoneNumber,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: ZText.zPassword,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: ZText.zSelectType,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              value: _registrationController.userType.value,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _registrationController.userType.value = newValue;
                }
              },
              items: <String>['normal', 'author']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_firstNameController.text.isEmpty ||
                    _lastNameController.text.isEmpty ||
                    _usernameController.text.isEmpty ||
                    _emailController.text.isEmpty ||
                    _phoneNumberController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  // Show validation error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields properly'),
                    ),
                  );
                } else {
                  _registrationController.registerUser(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    username: _usernameController.text,
                    email: _emailController.text,
                    phoneNumber: _phoneNumberController.text,
                    password: _passwordController.text,
                    userType: _registrationController.userType.value,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                ZText.zRegister,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // ElevatedButton(
            //   onPressed: () {
            //     _registrationController.registerUser(
            //       firstName: _firstNameController.text,
            //       lastName: _lastNameController.text,
            //       username: _usernameController.text,
            //       email: _emailController.text,
            //       phoneNumber: _phoneNumberController.text,
            //       password: _passwordController.text,
            //       userType: _registrationController.userType.value,
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //   ),
            //   child: const Text(
            //     ZText.zRegister,
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.off(() => LoginPage());
              },
              child: const Text(
                ZText.zAlreadyRegistered,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
