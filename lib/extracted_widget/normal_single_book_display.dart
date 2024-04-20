// import 'package:ebooks/details_page/controllers/single_book_details_controller.dart';
import 'package:ebooks/pages/details_page/views/single_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NormalSingleBookCard extends StatelessWidget {
  final String bookName;
  final String imagePath;
  final String pdfFilePath;
  final int ebookID;
  final String authorName;
  final String description;
  const NormalSingleBookCard({
    super.key,
    required this.bookName,
    required this.imagePath,
    required this.pdfFilePath,
    required this.ebookID,
    required this.description,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        // Get.find<SingleBookDetailsController>().onInit();
        // Get.find<SingleBookDetailsController>();
        // Get.put(SingleBookDetailsController());
        Get.back();

        Get.to(
          () => SingleBookDetails(
            bookName: bookName,
            imagePath: imagePath,
            pdfFilePath: pdfFilePath,
            ebookID: ebookID,
            authorName: authorName,
            bookData: const {},
            description: description,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        // color: Colors.red,
        width: media.width * 0.32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 20,
              child: Container(
                width: media.width * 0.32,
                height: media.width * 0.50,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    // color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 2),
                          blurRadius: 5)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imagePath,
                    width: media.width * 0.32,
                    height: media.width * 0.50,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/default_img.jpg', //  default asset image path
                        width: media.width * 0.32,
                        height: media.width * 0.50,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              // height: 15,
              height: 8,
            ),
            Container(
              // color: Colors.green,
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text(
                    bookName,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        // color: Color(0xff212121),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "By $authorName",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      // color: const Color(0xff212121).withOpacity(0.4),
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),

            // Card(
            //   elevation: 20,
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(10),
            //         boxShadow: const [
            //           BoxShadow(
            //               color: Colors.black38,
            //               offset: Offset(0, 2),
            //               blurRadius: 5)
            //         ]),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(10),
            //       child: Image.network(
            //         imagePath,
            //         width: media.width * 0.32,
            //         height: media.width * 0.50,
            //         fit: BoxFit.cover,
            //         errorBuilder: (BuildContext context, Object exception,
            //             StackTrace? stackTrace) {
            //           return Image.asset(
            //             'assets/default_img.jpg', //  default asset image path
            //             width: media.width * 0.32,
            //             height: media.width * 0.50,
            //             fit: BoxFit.cover,
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Container(
            //   margin: const EdgeInsets.only(left: 10),
            //   child: Column(
            //     children: [
            //       Text(
            //         bookName,
            //         maxLines: 3,
            //         textAlign: TextAlign.left,
            //         style: const TextStyle(
            //             color: Color(0xff212121),
            //             fontSize: 13,
            //             fontWeight: FontWeight.w700),
            //       ),
            //       const SizedBox(
            //         height: 8,
            //       ),
            //       Text(
            //         "By $authorName",
            //         maxLines: 1,
            //         textAlign: TextAlign.left,
            //         style: TextStyle(
            //           color: const Color(0xff212121).withOpacity(0.4),
            //           fontSize: 11,
            //         ),
            //       ),
            //       const SizedBox(
            //         height: 8,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
