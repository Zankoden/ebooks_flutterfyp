import 'package:ebooks/extracted_widget/custom_s_curve_shape.dart';
import 'package:ebooks/extracted_widget/home_view/app_bar.dart';
import 'package:ebooks/extracted_widget/home_view/category_all_books_show.dart';
import 'package:ebooks/extracted_widget/home_view/drawer_list.dart';
import 'package:ebooks/extracted_widget/home_view/genre_list.dart';
import 'package:ebooks/extracted_widget/home_view/monthly_launches_list.dart';
import 'package:ebooks/extracted_widget/home_view/recently_viewed_list.dart';
import 'package:ebooks/extracted_widget/home_view/slider_view_list.dart';
import 'package:ebooks/extracted_widget/s_curve_shape_widget.dart';
import 'package:ebooks/home_page/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    List genresArr = [
      {
        "name": "Graphic Novels",
        "img":
            "https://static01.nyt.com/images/2020/12/10/books/00GRAPHICNOVELS-TOPTEN-COMBO/00GRAPHICNOVELS-TOPTEN-COMBO-superJumbo.jpg"
      },
      {
        "name": "Graphic Novels",
        "img":
            "https://static01.nyt.com/images/2020/12/10/books/00GRAPHICNOVELS-TOPTEN-COMBO/00GRAPHICNOVELS-TOPTEN-COMBO-superJumbo.jpg"
      },
      {
        "name": "Graphic Novels",
        "img":
            "https://static01.nyt.com/images/2020/12/10/books/00GRAPHICNOVELS-TOPTEN-COMBO/00GRAPHICNOVELS-TOPTEN-COMBO-superJumbo.jpg"
      }
    ];

    return Scaffold(
      endDrawer: const DrawerListWidget(),
      // backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: FutureBuilder(
        future: Future.delayed(
            const Duration(seconds: 3)), // Simulating 5-second loading
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Loading indicator
            );
          } else {
            return SingleChildScrollView(
              child: SizedBox(
                height: media.height * 4.3, // fix it with dynamic list value
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        SCurveShapeWidget(media: media),
                        const Positioned(
                          top: 520,
                          left: 2,
                          child: CustomShape(),
                        ),
                        // Positioned(
                        //   top: 600,
                        //   left: 2,
                        //   child: SpiderShape(),
                        // ),
                        // const Positioned(
                        //   top: 700,
                        //   left: 2,
                        //   child: CustomShape(),
                        // ),
                        SizedBox(
                          width: Get.height * 1 / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: media.width * 0.1,
                              ),
                              const AppBarWidget(),
                              SliderView(media: media, controller: controller),
                              MonthlyLaunchesListView(
                                  media: media, controller: controller),
                              CategoryBooksListView(
                                  media: media, controller: controller),
                              GenreListView(media: media, genresArr: genresArr),
                              SizedBox(
                                height: media.width * 0.1,
                              ),
                              RecentlyViewedListView(
                                  media: media, controller: controller),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },

        ///
      ),
    );
  }
}
