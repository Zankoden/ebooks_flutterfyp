import 'package:ebooks/pages/details_page/views/single_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderBookCard extends StatelessWidget {
  const SliderBookCard({
    super.key,
    required this.bookName,
    required this.imagePath,
    required this.pdfFilePath,
    required this.ebookID,
    required this.description,
    required this.authorName,
  });

  final String bookName;
  final String imagePath;
  final String pdfFilePath;
  final int ebookID;
  final String authorName;
  final String description;

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
          margin: const EdgeInsets.symmetric(horizontal: 12),
          width: media.width * 0.32,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 20,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                          'assets/default_img.jpg',
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
                height: 15,
              ),
              Text(
                bookName,
                maxLines: 1,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "By $authorName",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          )),
    );
  }
}
