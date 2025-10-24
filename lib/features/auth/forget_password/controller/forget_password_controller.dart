import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordController extends GetxController {
  // UI Logic
  RxInt selectedOption = 0.obs;
  var emailorPhoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  RxInt secondsRemaining = 60.obs;
  RxBool isResendAvailable = false.obs;
  Timer? _timer;

  // API State
  var isLoading = false.obs;

  void selectOption(int option) {
    selectedOption.value = option;
  }

  bool isSelected(int option) {
    return selectedOption.value == option;
  }

  void startTimer() {
    secondsRemaining.value = 60;
    isResendAvailable.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isResendAvailable.value = true;
        _timer?.cancel();
      }
    });
  }

  void resendCode() {
    sendOtp(); // Instead of just restarting the timer, actually resend OTP
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  //  Backend Integration (Send OTP)

  Future<void> sendOtp() async {
    final email = emailorPhoneController.text.trim();

    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter your email");
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(
          "https://pastor-lili-backend-server.onrender.com/auth/emailVerify-otp",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 201) {
        Get.snackbar("Success", "OTP sent successfully");
        startTimer(); // Start countdown after successful send
        Get.toNamed("/otpScreen", arguments: {"email": email});
      } else {
        final data = jsonDecode(response.body);
        Get.snackbar("Error", data["message"] ?? "Failed to send OTP");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong while sending OTP");
    } finally {
      isLoading.value = false;
    }
  }
}
