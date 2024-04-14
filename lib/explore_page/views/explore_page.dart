import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/details_page/views/single_details_page.dart';
import 'package:ebooks/explore_page/controllers/explore_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExplorePage extends StatelessWidget {
  final ExplorePageController controller = Get.put(ExplorePageController());

  ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Row(
          children: [
            Text(ZText.zExplore),
            Expanded(child: SizedBox()),
            // InkWell(
            //   onTap: () {
            //     // Get.to(() => ProfilePage());
            //   },
            //   child: const Row(
            //     children: [CircleAvatar(child: Icon(Icons.person))],
            //   ),
            // ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: Future.delayed(
            const Duration(seconds: 3)), // Simulating 5-second loading
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Loading indicator
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              ZText.zSearchFavBooks,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          TextField(
                            controller: controller.searchController,
                            onChanged: (value) => controller.updateList(value),
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none),
                              hintText: ZText.zEgShreemadGeeta,
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 146, 145, 145)),
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.purple,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 50,
                            child: Obx(
                              () => ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.categories.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: controller.categories
                                        .map(
                                          (category) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: FilterChip(
                                              label: Text(
                                                  category.categoryName ?? ''),
                                              onSelected: (selected) {
                                                controller.filterByCategory(
                                                  category.categoryName!,
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Obx(
                              () => controller.displayList.isEmpty
                                  ? const Center(
                                      child: Text(
                                        ZText.zNoResultsFound,
                                      ),
                                    )
                                  : GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 15),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 0.55,
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 15,
                                              mainAxisSpacing: 1),
                                      itemCount: controller.displayList.length,
                                      itemBuilder: (context, index) {
                                        final ebook =
                                            controller.displayList[index];
                                        return SearchGridCell(
                                          index: index,
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
                      ),
                    ),
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

///
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
          // color: TColor.searchBGColor[index % TColor.searchBGColor.length],
          borderRadius: BorderRadius.circular(15),
          // border: Border.all(),
        ),
        // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
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
              style: const TextStyle(
                  // color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
