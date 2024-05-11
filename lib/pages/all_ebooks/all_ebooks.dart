import 'package:ebooks/extracted_widget/home_view/app_bar.dart';
import 'package:ebooks/extracted_widget/home_view/category_all_books_show.dart';
import 'package:ebooks/pages/home_page/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllEbooksPage extends StatelessWidget {
  AllEbooksPage({super.key});

  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                      const AppBarWidget(
                        appBarTitle: "All Ebooks",
                        appBarTitleColor: Color(0xff5ABD8C),
                      ),
                      CategoryBooksListView(
                          media: media, controller: controller),
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                    ],
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
