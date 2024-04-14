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
    // Fetch books when the controller is initialized
    fetchFavoriteBooks();
  }

  void toggleFavorite(int ebookID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');

      log("Ebook id fav add: $ebookID");

      // Convert ebookId to String
      String ebookIdString = ebookID.toString();

      // Send a request to add or remove the ebook from favorites in the database
      var response = await http.post(
        Uri.parse('${APIService.baseURL}/add_remove_favorite.php'),
        body: {
          'ebook_id': ebookIdString, // Use the ebook_id of the clicked ebook
          'user_id': userId.toString(), // Convert userId to String
          'action': isFavorite.value
              ? 'remove'
              : 'add', // Toggle action based on isFavorite value
        },
      );

      if (response.statusCode == 200) {
        // Update the isFavorite state based on the response
        isFavorite.value = !isFavorite.value;
        favoriteBooks
            .clear(); // cleared and called the fetching method so that It shows live list on navigating
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
        // Parse the response JSON
        List<dynamic> data = json.decode(response.body);
        List<Map<String, dynamic>> parsedData = [];

        // Process each item in the response data
        for (var item in data) {
          // Create a map for each item with the desired keys
          Map<String, dynamic> bookMap = {
            'bookName': item['title'] ?? '',
            'imagePath': "${APIService.baseURL}/${item['thumbnail_url']}",
            'pdfFilePath': "${APIService.baseURL}/${item['pdf_url']}",
            'ebookID': item['ebook_id'] ?? '',
          };
          // Add the processed item to the parsedData list
          parsedData.add(bookMap);
        }

        // Assign the parsed data to favoriteBooks
        favoriteBooks.assignAll(parsedData);
      } else {
        throw Exception('Failed to fetch favorite books');
      }
    } catch (e) {
      log('Error fetching favorite books: $e');
    }
  }
}
