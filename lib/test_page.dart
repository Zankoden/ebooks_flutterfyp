import 'dart:convert';
import 'dart:developer';

import 'package:ebooks/api/api_services.dart';
import 'package:ebooks/model/ebook_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TempSingleBookDetailsController extends GetxController {
  var isFavorite = false.obs;
  var favoriteBooks = <Map<String, dynamic>>[].obs;

  RxList<Ebook> books = <Ebook>[].obs;
  RxList<Ebook> recommendedBooksList = <Ebook>[].obs;
  RxList<Ebook> recommendedCategoryList = <Ebook>[].obs;

  @override
  void onInit() {
    super.onInit();
    super.onInit();
    fetchBooksAndRecommendations();
    // getBooks();
    // getRecommendedBooks();
    // getRecommendedCategoryBooks();
  }

  Future<void> fetchBooksAndRecommendations() async {
    try {
      await getBooks();
      getRecommendedBooks();
      getRecommendedCategoryBooks();
    } catch (e) {
      log("$e");
    }
  }

  Future<List<Ebook>> fetchEbooks() async {
    try {
      var response = await http.get(Uri.parse(APIService.fetchEbooksURL));

      log("Single fetch books response: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          // If the response is an array of ebooks
          return jsonData.map((ebookData) {
            return Ebook.fromJson(ebookData);
          }).toList();
        } else if (jsonData is Map) {
          // If the response is a single ebook
          return [Ebook.fromJson(jsonData as Map<String, dynamic>)];
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load ebooks: ${response.body}');
      }
    } catch (e) {
      log('Error fetching ebooks: $e');
      throw Exception('Failed to load ebooks: $e');
    }
  }

  Future<void> getBooks() async {
    try {
      books.value = await fetchEbooks();
    } catch (e) {
      log("$e");
    }
  }

  ///recommended
  void getRecommendedBooks() {
    getBooks();
    log("Single Fetch books list: $books");
    log("--------start of Single getRecommendedBooks-----🔥------------");
    log("Recommended list: $recommendedBooksList");
    if (books.isEmpty) return;

    recommendedBooksList.clear(); // Clear previous recommendations

    for (Ebook ebook in books) {
      double totalRating = 0;
      int numRatings = 0;

      if (ebook.reviews != null) {
        for (Reviews review in ebook.reviews!) {
          totalRating += review.rating ?? 0;
          numRatings++;
        }
      }

      if (numRatings > 0) {
        double avgRating = totalRating / numRatings;
        if (avgRating >= 4.0) {
          recommendedBooksList.add(ebook);
        }
      }
    }
    log("-------------🗿------------");
    log("Recommended list: $recommendedBooksList");
  }

  ///recommended category
  void getRecommendedCategoryBooks() {
    log("-------------🔥----start of getRecommendedCategoryBooks--------");
    if (books.isEmpty) return;

    Map<int, List<double>> categoryRatings =
        {}; // Map to store average ratings for each category
    Map<int, int> categoryBookCounts =
        {}; // Map to store the count of books in each category

    // Calculate average rating and count for each category
    for (Ebook ebook in books) {
      int categoryId = ebook.categoryId ?? -1;
      double totalRating = 0;
      int numRatings = 0;

      if (ebook.reviews != null) {
        for (Reviews review in ebook.reviews!) {
          totalRating += review.rating ?? 0;
          numRatings++;
        }
      }

      if (numRatings > 0) {
        double avgRating = totalRating / numRatings;

        // Update categoryRatings and categoryBookCounts maps
        if (!categoryRatings.containsKey(categoryId)) {
          categoryRatings[categoryId] = [avgRating];
          categoryBookCounts[categoryId] = 1;
        } else {
          categoryRatings[categoryId]!.add(avgRating);
          categoryBookCounts[categoryId] =
              (categoryBookCounts[categoryId] ?? 0) + 1;
        }
      }
    }

    // Calculate average rating for each category
    for (int categoryId in categoryRatings.keys) {
      double avgRating = categoryRatings[categoryId]!.reduce((a, b) => a + b) /
          categoryRatings[categoryId]!.length;
      int bookCount = categoryBookCounts[categoryId]!;

      if (avgRating >= 4.0 && bookCount >= 3) {
        // Consider categories with an average rating of 4.0 or higher and at least 3 books
        recommendedCategoryList
            .addAll(books.where((ebook) => ebook.categoryId == categoryId));
      }
    }

    // Remove duplicates
    recommendedCategoryList = recommendedCategoryList.toSet().toList().obs;

    recommendedCategoryList.shuffle();

    log("Recommended Category list: $recommendedCategoryList");
  }
}
