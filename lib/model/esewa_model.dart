import 'package:ebooks/api/api_services.dart';
import 'package:ebooks/constants/esewa.dart';
import 'package:ebooks/constants/text_strings.dart';
import 'package:ebooks/dash_board_screen.dart';
import 'package:ebooks/pages/profile/controllers/profile_controller.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Esewa {
  
  pay(String plan) {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: kEsewaClientID,
          secretId: kEsewaSecretKey,
        ),
        esewaPayment: EsewaPayment(
          productId: "1d71jd81",
          productName: "Product One",
          productPrice: "20",
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) async {
          debugPrint(":::SUCCESS::: => $data");
          // verifyTransactionStatus(data);
          
       
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
          ///
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }
}
