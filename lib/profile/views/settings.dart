import 'package:ebooks/main.dart';
import 'package:ebooks/profile/views/edit_profile_page.dart';
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
                    // const SizedBox(width: 180),
                    const SizedBox(width: 30),
                    // Icon(Iconsax.toggle_off),
                    Obx(
                      () => DropdownButton<String>(
                        value: themeController.themeMode.value.toString(),
                        onChanged: (String? newValue) {
                          switch (newValue) {
                            case 'ThemeMode.system':
                              themeController.changeTheme(ThemeMode.system);
                              break;
                            case 'ThemeMode.light':
                              themeController.changeTheme(ThemeMode.light);
                              break;
                            case 'ThemeMode.dark':
                              themeController.changeTheme(ThemeMode.dark);
                              break;
                          }
                        },
                        items: <String>[
                          'ThemeMode.system',
                          'ThemeMode.light',
                          'ThemeMode.dark'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )
                    // PopupMenuButton<String>(
                    //   itemBuilder: (BuildContext context) =>
                    //       <PopupMenuEntry<String>>[
                    //     const PopupMenuItem<String>(
                    //       value: 'system',
                    //       child: Text('System'),
                    //     ),
                    //     const PopupMenuItem<String>(
                    //       value: 'light',
                    //       child: Text('Light'),
                    //     ),
                    //     const PopupMenuItem<String>(
                    //       value: 'dark',
                    //       child: Text('Dark'),
                    //     ),
                    //   ],
                    //   onSelected: (String mode) {
                    //     switch (mode) {
                    //       case 'system':
                    //         themeController.changeTheme(ThemeMode.system);
                    //         break;
                    //       case 'light':
                    //         themeController.changeTheme(ThemeMode.light);
                    //         break;
                    //       case 'dark':
                    //         themeController.changeTheme(ThemeMode.dark);
                    //         break;
                    //     }
                    //   },
                    // ),
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
