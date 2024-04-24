import 'package:ebooks/pages/details_page/views/single_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchGridCell extends StatelessWidget {
  final int index;

  final String bookName;
  final String imagePath;
  final String pdfFilePath;
  final int ebookID;
  final String authorName;
  final String description;

  const SearchGridCell({
    super.key,
    required this.bookName,
    required this.imagePath,
    required this.pdfFilePath,
    required this.ebookID,
    required this.index,
    required this.description,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Get.to(() => SingleBookDetails(
              bookName: bookName,
              imagePath: imagePath,
              pdfFilePath: pdfFilePath,
              ebookID: ebookID,
              bookData: const {},
              description: description,
              authorName: authorName,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imagePath,
                width: media.width * 0.23 * 1.6,
                height: media.width * 0.23 * 2.5,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/default_img.jpg',
                    width: media.width * 0.23,
                    height: media.width * 0.23 * 1.45,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              bookName,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
