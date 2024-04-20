class APIService {
  // ///emulator ip address fixed
  static const String baseURL =
      'http://10.0.2.2/ebooks_point'; // Base URL of my API

  ///home ip address fixed
  // static const String baseURL =
  //     'http://192.168.1.70/ebooks_point'; // Base URL of my API

  ///college ip address
  // static const String baseURL =
  //     'http://192.168.30.102/ebooks_point'; // Base URL of my API

  static const String fetchEbooksURL = '$baseURL/fetch_ebooks.php';
  static const String getUserInfo = '$baseURL/get_user_info.php';
  static const String fetchCategories = '$baseURL/fetch_categories.php';
  static const String membershipURL = '$baseURL/membership.php';
  static const String cancelMembershipSubscription =
      '$baseURL/cancel_membership_subscription.php';
  static const String updateUserInfo = '$baseURL/update_user_info.php';
  static const String loginURL = '$baseURL/login.php';
  static const String registerURL = '$baseURL/register.php';
}
