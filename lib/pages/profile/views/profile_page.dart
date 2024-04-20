import 'package:ebooks/api/api_services.dart';
import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/pages/home_page/controllers/home_page_controller.dart';
import 'package:ebooks/pages/membership/membership_page.dart';
import 'package:ebooks/pages/profile/controllers/profile_controller.dart';
import 'package:ebooks/pages/profile/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final HomePageController controller = Get.put(HomePageController());

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ZText.zProfile,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff5ABD8C),
      ),
      body: FutureBuilder<void>(
        future: profileController.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              profileController.userInfo.value == null) {
            return const Center(child: Text(ZText.zFailedloadUser));
          } else {
            return Obx(() {
              if (profileController.userInfo.value != null) {
                return _buildProfileContent(profileController.userInfo.value!);
              } else {
                return const Center(child: Text(ZText.zUserInfoNull));
              }
            });
          }
        },
      ),
    );
  }

  Widget _buildProfileContent(Map<String, dynamic> userInfo) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "${APIService.baseURL}/${userInfo['profile_image_url']}"),
                  maxRadius: 75,
                ),
                const SizedBox(height: 10),
                Text(
                  userInfo['username'],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Card(
              elevation: 2.5,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff5ABD8C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Iconsax.user,
                          color: Colors.white,
                          size: 20,
                        ),
                        title: Text(
                          '${ZText.zFirstName}: ${userInfo['first_name']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Adjusted text size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Iconsax.user,
                          color: Colors.white,
                          size: 20,
                        ),
                        title: Text(
                          '${ZText.zLastName}: ${userInfo['last_name']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Adjusted text size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Iconsax.wallet,
                          color: Colors.white,
                          size: 20,
                        ),
                        title: Text(
                          '${ZText.zEmail}: ${userInfo['email']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Adjusted text size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Iconsax.call,
                          color: Colors.white,
                          size: 20,
                        ),
                        title: Text(
                          '${ZText.zPhoneNumber}: ${userInfo['phone_number']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Adjusted text size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Iconsax.verify,
                          color: Colors.white,
                          size: 20,
                        ),
                        title: Text(
                          '${ZText.zRole}: ${userInfo['role']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Adjusted text size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Iconsax.card,
                          color: Colors.white,
                          size: 20,
                        ),
                        title: Text(
                          '${ZText.zPlan}: ${userInfo['plan'] ?? 'Free Plan'}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Adjusted text size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (userInfo['membership_id'] != null) ...[
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    _buildButton(
                      text: ZText.zCancelSubscription,
                      icon: Icons.cancel,
                      onTap: () {
                        // Show cancellation dialog
                        Get.dialog(
                          AlertDialog(
                            title: const Text(ZText.zConfirmAction),
                            content:
                                const Text(ZText.zAreYouSureCancelSubscription),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(ZText.zNo),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await profileController.cancelSubscription();
                                  await profileController.getUserInfo();
                                  await controller.assignTempUserinfo();
                                  Get.back();
                                },
                                child: const Text(ZText.zYes),
                              ),
                            ],
                          ),
                        );
                      },
                      gradient: const LinearGradient(
                        colors: [Color(0xff5ABD8C), Color(0xff5ABD8C)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ] else ...[
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: _buildButton(
                        text: ZText.zGoForPremium,
                        icon: Icons.star,
                        onTap: () {
                          Get.to(() => MembershipPage());
                        },
                        gradient: const LinearGradient(
                          colors: [Color(0xff5ABD8C), Color(0xff5ABD8C)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width:
                  double.infinity, // Make buttons take full width of the screen
              child: Row(
                children: [
                  Expanded(
                    child: _buildButton(
                      text: ZText.zSettings,
                      icon: Icons.settings,
                      onTap: () {
                        Get.to(() => const SettingsPage());
                      },
                      gradient: const LinearGradient(
                        colors: [Color(0xff5ABD8C), Color(0xff5ABD8C)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildButton(
                      text: ZText.zLogOut,
                      icon: Icons.logout,
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text(ZText.zConfirmAction),
                            content: const Text(
                                "Are you sure you want to log out? You need to type in your credentials again for login!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(ZText.zNo),
                              ),
                              TextButton(
                                onPressed: () async {
                                  profileController.logout();
                                },
                                child: const Text(ZText.zYes),
                              ),
                            ],
                          ),
                        );
                      },
                      gradient: const LinearGradient(
                        colors: [Color(0xff5ABD8C), Color(0xff5ABD8C)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      {required String text,
      required IconData icon,
      required Function() onTap,
      required LinearGradient gradient}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 15), // Adjusted button padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              30), // Increased border radius for a rounded appearance
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // Added shadow for a raised effect
            ),
          ],
          gradient: gradient,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20, // Adjusted icon size
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18, // Adjusted text size
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
