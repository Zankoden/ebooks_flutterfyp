import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/extracted_widget/normal_single_book_display.dart';
import 'package:ebooks/pages/home_page/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';

class RecentlyViewedListView extends StatelessWidget {
  const RecentlyViewedListView({
    super.key,
    required this.media,
    required this.controller,
  });

  final Size media;
  final HomePageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Row(
            children: [
              Text(
                ZText.zRecentlyViewed,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        SizedBox(
          height: media.height * 1 / 2.0,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: controller.recentlyViewedBooks.isNotEmpty
                  ? controller.recentlyViewedBooks.length
                  : 3,
              itemBuilder: (context, index) {
                if (controller.recentlyViewedBooks.isEmpty) {
                  return const Stack(
                    children: [
                      NormalSingleBookCard(
                        bookName: ZText.zNoHistoryAvailable,
                        imagePath: 'assets/default_img.jpg',
                        pdfFilePath: '',
                        ebookID: -1,
                        description: '',
                        authorName: '',
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              ZText.zNoHistoryAvailable,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  final ebook = controller.recentlyViewedBooks[index];
                  return GestureDetector(
                    onTap: () {},
                    child: NormalSingleBookCard(
                      bookName: ebook.title ?? '',
                      imagePath: ebook.thumbnailUrl ?? '',
                      pdfFilePath: ebook.pdfUrl ?? '',
                      ebookID: ebook.ebookId ?? -1,
                      description: ebook.description ?? '',
                      authorName: ebook.authorName ?? '',
                    ),
                  );
                }
              }),
        ),
      ],
    );
  }
}
