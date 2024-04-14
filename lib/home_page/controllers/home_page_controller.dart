import 'dart:convert';
import 'dart:developer';
import 'package:ebooks/api/api_services.dart';
import 'package:ebooks/constants/ad_helper.dart';
import 'package:ebooks/model/category_model.dart';
import 'package:ebooks/profile/controllers/profile_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:ebooks/model/ebook_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int maxFailedLoadAttempts = 3;

class HomePageController extends GetxController {
  RxList<Ebook> books = <Ebook>[].obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<Ebook> premiumBooks = <Ebook>[].obs;
  RxList<Ebook> recentlyViewedBooks = <Ebook>[].obs;

  int interstitialLoadAttempts = 0;
  InterstitialAd? interstitialAd;

  @override
  void onInit() {
    super.onInit();
    createInterstitialAd();
    getBooks();
    getCategories();
    getCurrentMonthBooks();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          log("Success onAdnLoad step");
          interstitialAd = ad;
          interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log("Create nai Fail vayo yrr");
          interstitialLoadAttempts += 1;
          interstitialAd = null;
          if (interstitialLoadAttempts <= maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    log("Success onAdnLoad step 1");
    if (interstitialAd != null) {
      log("Success onAdnLoad step 2");
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          createInterstitialAd();
        },
      );
      interstitialAd!.show();
    }
    log(" onAdnLoad failed");
  }

  static Future<List<Ebook>> fetchEbooks() async {
    try {
      var response = await http.get(Uri.parse(APIService.fetchEbooksURL));

      log("Fetch Ebooks: ${response.body}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          // If the response is an array of ebooks
          return jsonData
              .map((ebookJson) => Ebook.fromJson(ebookJson))
              .toList();
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

  final ProfileController profileController = Get.put(ProfileController());
  Rx<Map<String, dynamic>?> userInfo = Rx<Map<String, dynamic>?>(null);

  Future<void> assignTempUserinfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      final response = await http.post(
        Uri.parse(APIService.getUserInfo),
        body: {
          'user_id': userId.toString(),
        },
      );

      // print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success']) {
          userInfo.value =
              data['user_info']; // Update userInfo with fetched data
          log("Test home user: ${userInfo.value}");
        } else {
          log('Failed to get user info: ${data['message']}');
        }
      } else {
        log('Failed to get user info');
      }
    }
  }

  Future<void> getBooks() async {
    try {
      // Await the result of fetchEbooks()
      List<Ebook> fetchedBooks = await fetchEbooks();
      // Assign the fetchedBooks to books.value
      books.value = fetchedBooks;
      // print("My Books $books");
    } catch (e) {
      log("$e");
    }
  }

  Future<void> getCurrentMonthBooks() async {
    try {
      books.value = await fetchEbooks();

      // Filter books uploaded in the current month
      final currentDate = DateTime.now();
      final currentMonth =
          DateFormat('MM').format(currentDate); // Get the current month
      final currentYear =
          DateFormat('yyyy').format(currentDate); // Get the current year
      final currentMonthBooks = books.where((book) {
        final uploadedDate = book.uploadedDate; // Access uploadedDate property
        final uploadDate =
            DateFormat('MM-yyyy').format(DateTime.parse(uploadedDate!));

        return uploadDate == '$currentMonth-$currentYear';
      }).toList();

      // Assign filtered books to premiumBooks
      premiumBooks.value = currentMonthBooks;
    } catch (e) {
      log("$e");
    }
  }

  static Future<List<Category>> fetchCategories() async {
    try {
      var response = await http.get(Uri.parse(APIService.fetchCategories));

      log("Fetch category: ${response.body} ");
      if (response.statusCode == 200) {
        // var jsonData = jsonDecode(response.body) as List<dynamic>;
        var jsonData = jsonDecode(response.body);
        return categoryFromJson(jsonEncode(jsonData));
      } else {
        throw Exception('Failed to load categories: ${response.body}');
      }
    } catch (e) {
      log('Error fetching categories: $e');
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<void> getCategories() async {
    // Add this method
    try {
      categories.value = await fetchCategories();
    } catch (e) {
      log("$e");
    }
    // print("My categories $categories");
  }

  void addToRecentlyViewed(Ebook ebook) {
    recentlyViewedBooks.add(ebook);
  }

  ///for drawer
  RxBool isDrawerOpen = false.obs;

  void openDrawer() {
    isDrawerOpen.value = true;
  }

  void closeDrawer() {
    isDrawerOpen.value = false;
  }
}
