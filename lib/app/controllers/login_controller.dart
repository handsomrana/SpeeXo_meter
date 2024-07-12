import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speed_meter_app/app/services/api_service.dart';
import '../views/home_view.dart';

class LoginController extends GetxController {
  final ApiService apiService =
      ApiService('https://example.com'); // Replace with your API base URL
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> login() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final email = emailController.text;
      final password = passwordController.text;

      // Validate email and password
      if (email.isEmpty || password.isEmpty) {
        errorMessage.value = 'Email and Password cannot be empty';
        isLoading.value = false;
        return;
      }

      bool success = await apiService.login(email, password);

      if (success) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        Get.off(() => HomeView()); // Navigate to HomeView on successful login
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
