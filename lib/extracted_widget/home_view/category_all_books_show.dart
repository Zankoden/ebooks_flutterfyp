import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/extracted_widget/normal_single_book_display.dart';
import 'package:ebooks/pages/home_page/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CategoryBooksListView extends StatelessWidget {
  const CategoryBooksListView({
    super.key,
    required this.media,
    required this.controller,
  });

  final Size media;
  final HomePageController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: media.height * 2.1,
      child: Obx(
        () => ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            final booksForCategory = controller.books
                .where((book) => book.categoryId == category.categoryId)
                .toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      Text(
                        category.categoryName ?? ZText.zNSorryFailedToLoad,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: 305,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: booksForCategory.length,
                    itemBuilder: (context, index) {
                      final ebook = booksForCategory[index];
                      return NormalSingleBookCard(
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
              ],
            );
          },
        ),
      ),
    );
  }
}
