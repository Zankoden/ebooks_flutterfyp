import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/explore_page/views/explore_page.dart';
import 'package:ebooks/favourites_page/controllers/favourites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class FavouritesPage extends StatelessWidget {
//   final FavouritesController favouritesController =
//       Get.put(FavouritesController());

//   FavouritesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const SizedBox(height: 40),
//           Expanded(
//             child: Obx(() {
//               if (favouritesController.favoriteBooks.isEmpty) {
//                 // Display "No saved books" text when there are no favorite books
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'No saved books',
//                         style: TextStyle(
//                           fontSize: 18,
//                           // color:  CustomColors.textColor,
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Get.to(ExplorePage());
//                         },
//                         child: const Text("Explore"),
//                       ),
//                     ],
//                   ),
//                 );
//               } else {
//                 // Display the list of favorite books
//                 return GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     childAspectRatio: MediaQuery.of(context).size.width /
//                         (MediaQuery.of(context).size.height / 1),
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 20,
//                     mainAxisSpacing: 0,
//                   ),
//                   itemCount: favouritesController.favoriteBooks.length,
//                   itemBuilder: (context, index) {
//                     final book = favouritesController.favoriteBooks[index];
//                     return NormalSingleBookCard(
//                       bookName: book['bookName'] ?? 'Default',
//                       imagePath: book['imagePath'] ?? 'Default',
//                       pdfFilePath: book['pdfFilePath'] ?? 'Default',
//                       ebookID: book['ebookID'] ?? 0,
//                     );
//                   },
//                 );
//               }
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

class FavouritesPage extends StatelessWidget {
  final FavouritesController favouritesController =
      Get.put(FavouritesController());

  FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ZText.zFavoriteBooks),
        actions: [
          IconButton(
            icon: const Icon(Icons.explore),
            onPressed: () {
              Get.to(ExplorePage());
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              ZText.zFavoriteBooks,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                // color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (favouritesController.favoriteBooks.isEmpty) {
                // Display "No saved books" text when there are no favorite books
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ZText.zNoSavedBooks,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(ExplorePage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text(
                          ZText.zExplore,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: favouritesController.favoriteBooks.length,
                  itemBuilder: (context, index) {
                    final book = favouritesController.favoriteBooks[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                book['imagePath'] ?? '',
                                width: 300,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              book['bookName'] ?? 'Default',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                // color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
