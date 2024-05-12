import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/pages/all_ebooks/all_ebooks.dart';
import 'package:ebooks/pages/home_page/controllers/home_page_controller.dart';
import 'package:ebooks/pages/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DrawerListWidget extends StatelessWidget {
  DrawerListWidget({
    super.key,
  });

  final HomePageController controller = Get.put(HomePageController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      width: 250,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              // bottomLeft: Radius.circular(120),
              bottomLeft: Radius.circular(200),
            ),
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 15)]),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => AllEbooksPage());
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Iconsax.watch,
                                size: 25,
                                color: Color(0xff5ABD8C),
                              ),
                              Text(
                                "View All Ebooks",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
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
                            // profileController.logout();
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Iconsax.logout,
                                color: Color(0xff5ABD8C),
                                size: 25,
                              ),
                              Text(
                                ZText.zLogOut,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     const Text(
                        //       "Genre",
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w700,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 5,
                        //     ),
                        //     PopupMenuButton<String>(
                        //       icon: const Icon(
                        //         Icons.arrow_drop_down,
                        //         color: Colors.black,
                        //       ),
                        //       onSelected: (value) {
                        //         Get.to(
                        //           SelectedCategory(
                        //               media: media, controller: controller),
                        //         );
                        //       },
                        //       itemBuilder: (BuildContext context) {
                        //         return [
                        //           const PopupMenuItem<String>(
                        //             value: 'fiction',
                        //             child: Text('Fiction'),
                        //           ),
                        //           const PopupMenuItem<String>(
                        //             value: 'non-fiction',
                        //             child: Text('Non-Fiction'),
                        //           ),
                        //           const PopupMenuItem<String>(
                        //             value: 'biography',
                        //             child: Text('Biography'),
                        //           ),
                        //           const PopupMenuItem<String>(
                        //             value: 'poetry',
                        //             child: Text('Poetry'),
                        //           ),
                        //         ];
                        //       },
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
