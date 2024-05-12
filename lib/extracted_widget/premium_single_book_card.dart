import 'package:ebooks/pages/home_page/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:ebooks/pages/details_page/views/single_details_page.dart';
import 'package:get/get.dart';

class PremiumSingleBookCard extends StatelessWidget {
  final HomePageController homePageController = Get.put(HomePageController());

  final String bookName;
  final String imagePath;
  final String pdfFilePath;
  final int ebookID;
  final String authorName;
  final String description;
  PremiumSingleBookCard({
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
        final userPlan = homePageController.userInfo.value?['plan'];
        if (userPlan == 'monthly' || userPlan == 'yearly') {
          await homePageController.assignTempUserinfo();
          Get.to(() => SingleBookDetails(
                bookName: bookName,
                imagePath: imagePath,
                pdfFilePath: pdfFilePath,
                ebookID: ebookID,
                description: description,
                bookData: const {},
                authorName: authorName,
              ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Upgrade to premium membership to access this feature.'),
            ),
          );
        }
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          width: media.width * 0.32,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Text(
                      bookName,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700),
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
              // Flexible(
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 5),
              //     child: IgnorePointer(
              //       ignoring: true,
              //       child: RatingBar.builder(
              //         initialRating: 3,
              //         minRating: 1,
              //         direction: Axis.horizontal,
              //         allowHalfRating: true,
              //         itemCount: 5,
              //         itemSize: 15,
              //         itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              //         itemBuilder: (context, _) => const Icon(
              //           Icons.star,
              //           color: Color.fromARGB(255, 226, 232, 45),
              //         ),
              //         onRatingUpdate: (rating) {},
              //       ),
              //     ),
              //   ),
              // )
            ],
          )),
    );
  }
}
