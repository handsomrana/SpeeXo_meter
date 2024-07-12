import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speed_meter_app/app/views/home_view.dart';
import '../views/login_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    // isLoggedIn = true;

    if (isLoggedIn) {
      _navigateToHome();
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Timer(const Duration(seconds: 3), () {
      Get.off(() => LoginView());
    });
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 1), () {
      Get.off(() => HomeView());
    });
  }
}
