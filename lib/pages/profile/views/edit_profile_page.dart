import 'package:ebooks/api/api_services.dart';
import 'package:ebooks/pages/profile/controllers/edit_profile_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProfilePage extends StatelessWidget {
  final EditProfilePageController editProfilePageController =
      Get.put(EditProfilePageController());

  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: editProfilePageController.getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "${APIService.baseURL}/${editProfilePageController.userInfo.value!['profile_image_url']}"),
                    maxRadius: 75,
                  ),
                  TextButton(
                    onPressed: () {
                      editProfilePageController.pickProfileImage();
                    },
                    child: const Text('Change Profile Picture'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller:
                              editProfilePageController.firstNameController,
                          expands: false,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            prefixIcon: Icon(Iconsax.user),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller:
                              editProfilePageController.lastNameController,
                          expands: false,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            prefixIcon: Icon(Iconsax.user),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  TextField(
                    controller: editProfilePageController.emailController,
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Iconsax.direct),
                    ),
                  ),
                  TextField(
                    controller: editProfilePageController.phoneNumberController,
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Iconsax.call),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        editProfilePageController.updateProfile(
                          editProfilePageController.firstNameController.text,
                          editProfilePageController.lastNameController.text,
                          editProfilePageController.emailController.text,
                          editProfilePageController.phoneNumberController.text,
                          editProfilePageController.profilePicController.text,
                        );

                        
                        Get.back(result: true);
                      },
                      child: const Text('Save Changes'),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
