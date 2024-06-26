import 'dart:developer';
import 'dart:io';
import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/pages/details_page/controllers/single_book_details_controller.dart';
import 'package:ebooks/extracted_widget/normal_single_book_display.dart';
import 'package:ebooks/extracted_widget/show_more_text.dart';
import 'package:ebooks/pages/favourites_page/controllers/favourites_controller.dart';
import 'package:ebooks/pages/home_page/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

class SingleBookDetails extends StatelessWidget {
  final String bookName;
  final String imagePath;
  final String pdfFilePath;
  final int ebookID;
  final String authorName;
  final String description;
  final Map<String, dynamic> bookData;
  final FavouritesController favouritesController =
      Get.put(FavouritesController());

  final SingleBookDetailsController singleBookDetailsController =
      Get.put(SingleBookDetailsController());

  SingleBookDetails({
    super.key,
    required this.bookName,
    required this.imagePath,
    required this.pdfFilePath,
    required this.ebookID,
    required this.bookData,
    required this.description,
    required this.authorName,
  });

  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookName),
      ),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NormalSingleBookCard(
                                bookName: bookName,
                                imagePath: imagePath,
                                pdfFilePath: pdfFilePath,
                                ebookID: ebookID,
                                description: description,
                                authorName: authorName,
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${ZText.zBookName} $bookName',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Row(
                                      children: [
                                        Text(
                                          ZText.zAddFavourites,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Obx(
                                      () => IconButton(
                                        onPressed: () {
                                          favouritesController
                                              .toggleFavorite(ebookID);
                                        },
                                        icon: Icon(
                                          favouritesController.isFavorite.value
                                              ? Icons.bookmark
                                              : Icons.bookmark_border,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (pdfFilePath.isNotEmpty) {
                                          final userPlan = controller
                                              .userInfo.value?['plan'];
                                          if (userPlan == 'monthly' ||
                                              userPlan == 'yearly') {
                                            await controller
                                                .assignTempUserinfo();
                                            Get.to(() => PdfViewPage(
                                                pdfUrl: pdfFilePath));
                                          } else {
                                            controller.showInterstitialAd();
                                            await Future.delayed(
                                              const Duration(seconds: 1),
                                            );
                                            Get.to(() => PdfViewPage(
                                                pdfUrl: pdfFilePath));
                                          }
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    ZText.zPDFNotAvailable),
                                                content: const Text(
                                                    ZText.zSorryNoPDF),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text(ZText.zOK),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: const Text(ZText.zRead),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      ZText.zDescription,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ShowMoreText(
                      text: description,
                      maxLength: 200,
                    ),
                    const SizedBox(height: 20),
                    if (singleBookDetailsController
                        .recommendedCategoryList.isNotEmpty) ...[
                      const Text(
                        ZText.zRecommendedForYou,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 280,
                        child: Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: singleBookDetailsController
                                .recommendedCategoryList.length,
                            itemBuilder: (context, index) {
                              final ebook = singleBookDetailsController
                                  .recommendedCategoryList[index];

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
                      ),
                    ],
                    const SizedBox(height: 10),
                    if (singleBookDetailsController
                        .recommendedBooksList.isNotEmpty) ...[
                      const Text(
                        ZText.zRecommendedTopList,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: singleBookDetailsController
                                .recommendedBooksList.length,
                            itemBuilder: (context, index) {
                              final ebook = singleBookDetailsController
                                  .recommendedBooksList[index];
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
                      ),
                    ]
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class PdfViewPage extends StatelessWidget {
  final String pdfUrl;

  const PdfViewPage({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ZText.zPDFViewer),
      ),
      body: FutureBuilder(
        future: _fetchPdfFile(pdfUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            log("First if mai adkiyo pdf");
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            log("second else if ma adkiyo pdf");
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            log("else ma aayo, aayo pdf aayo");
            File? pdfFile = snapshot.data;
            if (pdfFile != null) {
              return PDFView(
                filePath: pdfFile.path,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: false,
                pageSnap: true,
                pageFling: false,
                onRender: (pages) {
                  log("PDF rendered");
                },
                onError: (error) {
                  log(error.toString());
                },
                onPageError: (page, error) {
                  log('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController pdfViewController) {},
              );
            } else {
              return const Center(child: Text(ZText.zPDFLoading));
            }
          }
        },
      ),
    );
  }

  Future<File?> _fetchPdfFile(String pdfUrl) async {
    try {
      return await DefaultCacheManager().getSingleFile(pdfUrl);
    } catch (e) {
      log('Error fetching PDF file: $e');
      return null;
    }
  }
}
