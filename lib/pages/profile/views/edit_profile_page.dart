import 'package:ebooks/api/api_services.dart';
import 'package:ebooks/pages/profile/controllers/edit_profile_page_controller.dart';
import 'package:ebooks/pages/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProfilePage extends StatelessWidget {
  final EditProfilePageController editProfilePageController =
      Get.put(EditProfilePageController());
  final ProfileController profilePageController = Get.put(ProfileController());

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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: editProfilePageController
                                  .userInfo.value?['profile_image_url'] !=
                              null
                          ? NetworkImage(
                              "${APIService.baseURL}/${editProfilePageController.userInfo.value!['profile_image_url']}")
                          : const AssetImage(
                                  'assets/images/default_profile.png')
                              as ImageProvider,
                      maxRadius: 75,
                    ),
                    TextButton(
                      onPressed: () {
                        editProfilePageController.pickProfileImage();
                      },
                      child: const Text('Change Profile Picture'),
                    ),
                    Obx(() {
                      if (editProfilePageController.profileImageFile.value !=
                          null) {
                        return Image.file(
                          editProfilePageController.profileImageFile.value!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
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
                      controller:
                          editProfilePageController.phoneNumberController,
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
                            editProfilePageController
                                .phoneNumberController.text,
                            editProfilePageController.profileImageFile.value,
                          );
                          profilePageController.getUserInfo();
                          Get.back(result: true);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 129, 149, 166)),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
