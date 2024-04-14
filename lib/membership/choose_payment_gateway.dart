import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/dash_board_screen.dart';
import 'package:ebooks/model/esewa_model.dart';
import 'package:ebooks/api/api_services.dart';
import 'package:ebooks/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChoosePaymentGatewayController extends GetxController {}

class ChoosePaymentGateway extends StatelessWidget {
  const ChoosePaymentGateway(
      {super.key, required this.amount, required this.plan});

  final int amount;
  final String plan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ZText.zChoosePaymentGateway),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          PaymentOptionCard(
            icon: Icons.credit_card,
            title: 'Esewa',
            onTap: () {
              Esewa esewa = Esewa();
              esewa.pay(plan);
            },
          ),
          PaymentOptionCard(
            icon: Icons.payment,
            title: ZText.zKhalti,
            onTap: () {
              KhaltiScope.of(context).pay(
                config: PaymentConfig(
                  amount: amount,
                  productIdentity: "productIdentity",
                  productName: "productName",
                ),
                preferences: [
                  PaymentPreference.khalti,
                ],
                onSuccess: (onSuccess) async {
                  Get.snackbar(
                    ZText.zResult,
                    ZText.zPaymentSuccessful,
                    snackPosition: SnackPosition.BOTTOM,
                  );

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  int? userId = prefs.getInt('user_id');

                  // Send a POST request to  API
                  var response = await http.post(
                    Uri.parse(APIService.membershipURL),
                    body: {
                      'user_id': userId.toString(),
                      'plan': plan.toString(),
                    },
                  );

                  // Check if the request was successful
                  if (response.statusCode == 200) {
                    Get.find<ProfileController>().getUserInfo();
                    Get.snackbar(
                      ZText.zResult,
                      ZText.zSubscriptionSuccessful,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    Get.snackbar(
                      ZText.zResult,
                      ZText.zSubscriptionFailed,
                    );
                  }
                  Get.offAll(DashboardScreen());
                },
                onFailure: (onFailure) {
                  Get.snackbar(
                    ZText.zResult,
                    ZText.zPaymentFailed,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                onCancel: () {
                  Get.snackbar(
                    ZText.zResult,
                    ZText.zPaymentCancelled,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              );
            },
          ),
          PaymentOptionCard(
            icon: Icons.payment,
            title: ZText.zPayPal,
            onTap: () {},
          ),
          PaymentOptionCard(
            icon: Icons.mobile_screen_share,
            title: ZText.zMobileWallet,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

///
class PaymentOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const PaymentOptionCard({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: onTap as void Function()?,
        leading: Icon(icon, size: 36.0, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
