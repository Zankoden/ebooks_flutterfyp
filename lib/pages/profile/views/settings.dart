import 'package:ebooks/pages/profile/views/edit_profile_page.dart';
import 'package:ebooks/themes/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const InkWell(
                child: Row(
                  children: [
                    SizedBox(width: 18),
                    Icon(Iconsax.lock),
                    SizedBox(width: 15),
                    Text("Change Password"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Get.to(() => EditProfilePage());
                },
                child: const Row(
                  children: [
                    SizedBox(width: 18),
                    Icon(Iconsax.edit),
                    SizedBox(width: 15),
                    Text("Edit Profile Information"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                child: Row(
                  children: [
                    const SizedBox(width: 18),
                    const Icon(Iconsax.moon),
                    const SizedBox(width: 15),
                    const Text("Switch Modes"),
                    const SizedBox(width: 30),
                    Obx(
                      () => DropdownButton<ThemeMode>(
                        value: themeController.themeMode.value,
                        onChanged: (ThemeMode? newValue) {
                          if (newValue != null) {
                            themeController.changeTheme(newValue);
                          }
                        },
                        items: ThemeMode.values
                            .map<DropdownMenuItem<ThemeMode>>((ThemeMode mode) {
                          return DropdownMenuItem<ThemeMode>(
                            value: mode,
                            child: Text(mode.toString().split('.').last),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
