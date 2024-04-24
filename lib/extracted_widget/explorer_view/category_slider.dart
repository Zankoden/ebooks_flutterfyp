import 'package:ebooks/pages/explore_page/controllers/explore_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryViewSliderWidget extends StatelessWidget {
  const CategoryViewSliderWidget({
    super.key,
    required this.controller,
  });

  final ExplorePageController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Obx(
                    () => FilterChip(
                      selected: controller.isSelectedMap['All'] ?? false,
                      label: const Text('All'),
                      onSelected: (bool value) {
                        for (var key in controller.isSelectedMap.keys) {
                          controller.isSelectedMap[key] = false;
                        }
                        controller.isSelectedMap['All'] = true;

                        controller.displayList.value =
                            controller.books.toList();
                      },
                    ),
                  ));
            } else {
              final category = controller.categories[index - 1];
              return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Obx(
                    () => FilterChip(
                      selected: controller
                              .isSelectedMap[category.categoryName ?? ''] ??
                          false,
                      label: Text(category.categoryName ?? ''),
                      onSelected: (bool value) {
                        for (var key in controller.isSelectedMap.keys) {
                          controller.isSelectedMap[key] = false;
                        }
                        controller.isSelectedMap[category.categoryName!] = true;
                        controller.filterByCategory(category.categoryName!);
                      },
                    ),
                  ));
            }
          },
        ),
      ),
    );
  }
}
