import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/pages/home_page/controllers/home_page_controller.dart';
import 'package:ebooks/pages/membership/choose_payment_gateway.dart';
import 'package:ebooks/pages/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class MembershipPage extends StatelessWidget {
  MembershipPage({super.key});

  final ProfileController profileController = Get.put(ProfileController());
  final HomePageController homeController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ZText.zEBooksPremiumMembershipTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              ZText.zUnlockPremiumSlogan,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showSubscriptionDialog();
              },
              child: const Text(ZText.zGetPremiumMembershipSlogan),
            ),
          ],
        ),
      ),
    );
  }

  void _showSubscriptionDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      Get.dialog(
        AlertDialog(
          title: const Text(ZText.zChooseSubscriptionPlan),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text(ZText.zMonthlySubscription),
                subtitle: const Text(ZText.zMonthlyBill),
                onTap: () async {
                  Get.to(const ChoosePaymentGateway(
                    amount: 1000,
                    plan: 'monthly',
                  ));
                },
              ),
              ListTile(
                title: const Text(ZText.zYearlySubscription),
                subtitle: const Text(ZText.zYearlyBill),
                onTap: () async {
                  Get.to(const ChoosePaymentGateway(
                    amount: 1000,
                    plan: 'yearly',
                  ));
                },
              ),
            ],
          ),
        ),
      );
    } else {
      Get.snackbar(
        ZText.zResult,
        ZText.zUserIDNotFound,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
