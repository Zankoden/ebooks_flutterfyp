import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/extracted_widget/search_grid_cell.dart';
import 'package:ebooks/pages/explore_page/controllers/explore_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchItemViewWidget extends StatelessWidget {
  const SearchItemViewWidget({
    super.key,
    required this.controller,
  });

  final ExplorePageController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Obx(
        () => controller.displayList.isEmpty
            ? const Center(
                child: Text(
                  ZText.zNoResultsFound,
                ),
              )
            : GridView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.52,
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 1),
                itemCount: controller.displayList.length,
                itemBuilder: (context, index) {
                  final ebook = controller.displayList[index];
                  return SearchGridCell(
                    index: index,
                    bookName: ebook.title ?? '',
                    imagePath: ebook.thumbnailUrl ?? '',
                    pdfFilePath: ebook.pdfUrl ?? '',
                    ebookID: ebook.ebookId ?? -1,
                    description: ebook.description ?? '',
                    authorName: ebook.authorName ?? '',
                  );
                },
              ),
      ),
    );
  }
}

