import 'package:ebooks/pages/explore_page/views/explore_page.dart';
import 'package:ebooks/pages/favourites_page/views/favourites_page.dart';
import 'package:ebooks/pages/home_page/views/home_page.dart';
import 'package:ebooks/pages/profile/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;

  List<Widget> widgetList = [
    HomePage(),
    ExplorePage(),
    FavouritesPage(),
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    currentIndex.value = index;
  }
}

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: Drawer(
      //   child: Container(
      //     height: 100,
      //     width: 100,
      //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      //     child: ListView(
      //       children: [
      //         ListTile(
      //           title: const Text('Drawer Item 1'),
      //           onTap: () {
      //             // Implement action for drawer item 1
      //             Get.back(); // Close the drawer
      //           },
      //         ),
      //         ListTile(
      //           title: const Text('Drawer Item 2'),
      //           onTap: () {
      //             // Implement action for drawer item 2
      //             Get.back(); // Close the drawer
      //           },
      //         ),
      //         // Add more ListTile widgets for additional drawer items
      //       ],
      //     ),
      //   ),
      // ),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.widgetList,
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Card(
              elevation: 10,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color(0xff5ABD8C),
                fixedColor: const Color.fromARGB(255, 255, 255, 255),
                showUnselectedLabels: false,
                unselectedLabelStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
                selectedLabelStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                unselectedIconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 147, 139, 139),
                ),
                selectedIconTheme: const IconThemeData(color: Colors.white),
                onTap: controller.onTabTapped,
                currentIndex: controller.currentIndex.value,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: "Search"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favourites"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
