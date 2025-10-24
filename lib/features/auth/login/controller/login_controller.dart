import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isPasswordObscure = true.obs;
  var isChecked = false.obs;
  var isLoading = false.obs;
  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }
}
