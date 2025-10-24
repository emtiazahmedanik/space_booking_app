// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OtpController extends GetxController {
  var isVerifying = false.obs;
  var otpCode = ''.obs;

  final String email;

  OtpController(this.email);

  Future<void> verifyOtp() async {
    if (otpCode.value.isEmpty) {
      EasyLoading.showError("Please enter the OTP");
      return;
    }

    isVerifying.value = true;
    EasyLoading.show(status: "Verifying OTP...");

    try {
      final response = await http.post(
        Uri.parse(
          "https://pastor-lili-backend-server.onrender.com/auth/verify-otp",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otpCode.value}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess("OTP verified successfully");
        Get.toNamed("/createNewPassword", arguments: {"email": email});
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(data["message"] ?? "Invalid or expired OTP");
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Something went wrong. Please try again.");
    } finally {
      isVerifying.value = false;
    }
  }
}
