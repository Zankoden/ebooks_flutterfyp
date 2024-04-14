import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/extracted_widget/premium_single_book_card.dart';
import 'package:ebooks/home_page/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyLaunchesListView extends StatelessWidget {
  const MonthlyLaunchesListView({
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
          child: const Row(children: [
            Text(
              ZText.zNewMonthlyLaunches,
              style: TextStyle(
                  color: Color(0xff212121),
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            )
          ]),
        ),
        SizedBox(
          height: media.height * 1 / 2.2,
          child: Obx(
            () => ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: controller.premiumBooks.isNotEmpty
                  ? controller.premiumBooks.length
                  : 3,
              itemBuilder: (context, index) {
                if (controller.premiumBooks.isEmpty) {
                  return Stack(
                    children: [
                      PremiumSingleBookCard(
                        bookName: ZText.zNoPremiumBooks,
                        imagePath: 'assets/default_img.jpg',
                        pdfFilePath: '',
                        ebookID: -1,
                        description: '',
                        authorName: '',
                      ),
                      const Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              ZText.zNoPremiumBooks,
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
                  final ebook = controller.premiumBooks[index];
                  return GestureDetector(
                    onTap: () {},
                    child: PremiumSingleBookCard(
                      bookName: ebook.title ?? '',
                      imagePath: ebook.thumbnailUrl ?? '',
                      pdfFilePath: ebook.pdfUrl ?? '',
                      ebookID: ebook.ebookId ?? -1,
                      description: ebook.description ?? '',
                      authorName: ebook.authorName ?? '',
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
