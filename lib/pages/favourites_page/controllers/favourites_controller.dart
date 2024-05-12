import 'dart:convert';
import 'dart:developer';
import 'package:ebooks/api/api_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesController extends GetxController {
  var favoriteBooks = <Map<String, dynamic>>[].obs;
  var isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchFavoriteBooks();
  }

  void toggleFavorite(int ebookID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');

      // log("Ebook id fav add: $ebookID");

      String ebookIdString = ebookID.toString();

      var response = await http.post(
        Uri.parse('${APIService.baseURL}/add_remove_favorite.php'),
        body: {
          'ebook_id': ebookIdString,
          'user_id': userId.toString(),
          'action': isFavorite.value ? 'remove' : 'add',
        },
      );

      if (response.statusCode == 200) {
        isFavorite.value = !isFavorite.value;
        favoriteBooks.clear();
        fetchFavoriteBooks();
      } else {
        throw Exception('Failed to toggle favorite status');
      }
    } catch (e) {
      log('Error toggling favorite: $e');
    }
  }

  void fetchFavoriteBooks() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');
      log("Current user: $userId");

      var response = await http.post(
        Uri.parse('${APIService.baseURL}/fetch_favourites.php'),
        body: {
          'user_id': userId.toString(),
        },
      );

      log("The body fav fetch: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Map<String, dynamic>> parsedData = [];

        for (var item in data) {
          Map<String, dynamic> bookMap = {
            'ebook_id': item['ebook_id'] ?? '',
            'bookName': item['title'] ?? '',
            'author_id': item['author_id'] ?? '',
            'description': item['description'] ?? '',
            'pdf_url': "${APIService.baseURL}/${item['pdf_url']}",
            'category_id': item['category_id'],
            'imagePath': "${APIService.baseURL}/${item['thumbnail_url']}",
            'uploaded_date': item['uploaded_date'] ?? '',
          };

          parsedData.add(bookMap);
        }

        favoriteBooks.assignAll(parsedData);
      } else {
        throw Exception('Failed to fetch favorite books');
      }
    } catch (e) {
      log('Error fetching favorite books: $e');
    }
  }
}
