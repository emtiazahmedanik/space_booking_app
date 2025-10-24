import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pastor_lili/core/services/end_points.dart';
import 'package:pastor_lili/core/services/storage_service.dart';

class AuthService {
  static Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show(status: "Creating account...");

      final body = {
        "fullName": fullName.trim(),
        "email": email.trim(),
        "password": password.trim(),
      };

      final response = await http.post(
        Uri.parse(Urls.signUp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 201 && decoded["status"] == "success") {
        EasyLoading.showSuccess(decoded["message"] ?? "Signup successful");

        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed('/loginScreen');
      } else {
        EasyLoading.showError(decoded["message"] ?? "Signup failed");
      }

      if (kDebugMode) {
        print("Signup Response: ${response.body}");
      }
    } catch (e) {
      EasyLoading.showError("Error: $e");
      if (kDebugMode) {
        print("Signup Exception: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<void> login({
    required String email,
    required String password,
    bool isEmailPrivate = false,
  }) async {
    try {
      EasyLoading.show(status: "Logging in...");

      final userEmail = isEmailPrivate
          ? 'anonymous_${DateTime.now().millisecondsSinceEpoch}@yourapp.com'
          : email.trim();

      final body = {"email": userEmail, "password": password.trim()};

      final response = await http.post(
        Uri.parse(Urls.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final decoded = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          decoded["status"] == "success") {
        EasyLoading.showSuccess(decoded["message"] ?? "Login successful");

        final accessToken = decoded['data']['accessToken'];
        final userId = decoded['data']['user']['id'];

        await StorageService.saveToken(accessToken, userId);
        await StorageService.saveUserId(userId);
        Get.offAllNamed('/bottomNavbarView');
      } else {
        EasyLoading.showError(decoded["message"] ?? "Login failed");
      }

      if (kDebugMode) {
        print("Login Response: ${response.body}");
      }
    } catch (e) {
      EasyLoading.showError("Error: $e");
      if (kDebugMode) {
        print("Login Exception: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
