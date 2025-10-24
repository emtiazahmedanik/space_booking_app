import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/services/auth_service.dart';

class SignUpController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  /// Email regex pattern
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Validate form fields before signup
  bool validateInputs() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty) {
      EasyLoading.showError("Full name is required");
      EasyLoading.showError("Email is required");
      return false;
    }

    if (!emailRegex.hasMatch(email)) {
      EasyLoading.showError("Enter a valid email address");
      return false;
    }

    if (password.isEmpty) {
      EasyLoading.showError("Password is required");
      return false;
    }

    if (password.length < 6) {
      EasyLoading.showError("Password must be at least 6 characters");
      return false;
    }

    if (confirmPassword.isEmpty) {
      EasyLoading.showError("Please confirm your password");
      return false;
    }

    if (password != confirmPassword) {
      EasyLoading.showError("Passwords do not match");
      return false;
    }

    return true;
  }

  Future<void> signUp() async {
    if (!validateInputs()) return;

    await AuthService.signUp(
      fullName: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
