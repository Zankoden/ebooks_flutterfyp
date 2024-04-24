import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebooks/extracted_widget/slider_book_card.dart';
import 'package:ebooks/pages/home_page/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderView extends StatelessWidget {
  const SliderView({
    super.key,
    required this.media,
    required this.controller,
  });

  final Size media;
  final HomePageController controller;

  @override
  Widget build(BuildContext context) {
    controller.getBooks();
    return Obx(() => SizedBox(
          width: media.width,
          height: media.width * 0.8,
          child: CarouselSlider.builder(
            itemCount: controller.books.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              if (itemIndex >= 0 && itemIndex < controller.books.length) {
                var ebook = controller.books[itemIndex];
                return SliderBookCard(
                  bookName: ebook.title ?? '',
                  imagePath: ebook.thumbnailUrl ?? '',
                  pdfFilePath: ebook.pdfUrl ?? '',
                  ebookID: ebook.ebookId ?? -1,
                  description: ebook.description ?? '',
                  authorName: ebook.authorName ?? '',
                );
              } else {
                log('Invalid itemIndex: $itemIndex');
                return const SizedBox();
              }
            },
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1,
              enlargeCenterPage: true,
              viewportFraction: 0.45,
              enlargeFactor: 0.4,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            ),
          ),
        ));
  }
}
