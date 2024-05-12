import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/extracted_widget/normal_single_book_display.dart';
import 'package:ebooks/pages/home_page/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedCategory extends StatelessWidget {
  SelectedCategory({
    super.key,
   
  });

 

  final controller = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    // final filteredCategories = homeController.categories
    //     .where((category) =>
    //         category.categoryName == 'Encyclopedia' ||
    //         category.categoryName == 'Biography')
    //     .toList();

    return SizedBox(
                        
                        height: 800,
                        child: Obx(
                          () => ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.filteredCategories.length,
                            itemBuilder: (context, index) {
                              final category =
                                  controller.filteredCategories[index];
                              final booksForCategory = controller.books
                                  .where((book) =>
                                      book.categoryId == category.categoryId)
                                  .toList();

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            category.categoryName ??
                                                ZText.zNSorryFailedToLoad,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 305,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 8),
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
