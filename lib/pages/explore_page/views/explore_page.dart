import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/extracted_widget/explorer_view/category_slider.dart';
import 'package:ebooks/extracted_widget/explorer_view/search_item_view.dart';
import 'package:ebooks/pages/explore_page/controllers/explore_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExplorePage extends StatelessWidget {
  final ExplorePageController controller = Get.put(ExplorePageController());

  ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Row(
          children: [
            Text(ZText.zExplore),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    ZText.zSearchFavBooks,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                TextField(
                  controller: controller.searchController,
                  onChanged: (value) => controller.updateList(value),
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none),
                    hintText: ZText.onTheroad,
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 146, 145, 145)),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.purple,
                  ),
                ),
                const SizedBox(height: 16),
                CategoryViewSliderWidget(controller: controller),
                const SizedBox(height: 16),
                SearchItemViewWidget(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
