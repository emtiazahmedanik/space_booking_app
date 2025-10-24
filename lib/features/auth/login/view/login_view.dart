import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/common/widgets/custom_button.dart';
import 'package:pastor_lili/core/common/widgets/custom_textfield.dart';
import 'package:pastor_lili/core/services/auth_service.dart';
import 'package:pastor_lili/core/services/firebase/firebase_auth_service.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/core/utils/constants/icon_path.dart';
import 'package:pastor_lili/features/auth/login/controller/login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.put(LoginController());
  //final GoogleSignInService _googleService = GoogleSignInService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Welcome Back 👋",
                          style: getTextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "Sign in to continue booking spaces with ease.",
                        style: getTextStyle(
                          color: const Color(0xFFA3A3A3),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 70),
                      CustomTextField(
                        controller: controller.emailController,
                        hintText: "Enter your email or phone",
                        prefixIcon: Icons.email_outlined,
                      ),
                      SizedBox(height: 18),
                      CustomTextField(
                        controller: controller.passwordController,
                        hintText: "Password",
                        prefixIcon: Icons.lock_open_outlined,
                        isObscure: true,
                        suffixIcon: Icons.visibility_off,
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.isChecked.value,
                              onChanged: controller.toggleCheckbox,
                              checkColor: Colors.white,
                              activeColor: AppColors.primaryColor,
                              side: BorderSide(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          Text(
                            "Remember me",
                            style: getTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFFA3A3A3),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Get.toNamed('/forgetPasswordScreen');
                            },
                            child: Text(
                              "Forgot Password?",
                              style: getTextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      CustomButton(
                        text: "Login",
                        ontap: () {
                          AuthService.login(
                            email: controller.emailController.text,
                            password: controller.passwordController.text,
                          );
                        },
                      ),
                      const SizedBox(height: 60),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          const SizedBox(width: 8),
                          Text(
                            "Or",
                            style: getTextStyle(
                              color: const Color(0xFF737373),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final GoogleSignInService googleService =
                                  GoogleSignInService();
                              if (googleService.isAuthorized == false) {
                                await googleService.signIn();
                              }
                            },
                            child: Image.asset(
                              IconPath.googleButton,
                              width: 60,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 70),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: getTextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7D7D7D),
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: "Signup",
                              style: getTextStyle(
                                color: Color(0xFFAA8D34),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.offAllNamed('/signupScreen');
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
