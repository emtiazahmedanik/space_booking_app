import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/common/widgets/custom_button.dart';
import 'package:pastor_lili/core/common/widgets/custom_textfield.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/auth/signup/controller/sign_up_controller.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final SignUpController controller = Get.put(SignUpController());

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
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Create Your Account",
                          style: getTextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: 40),
                      Text(
                        "Full name",
                        style: getTextStyle(
                          color: Color(0xFF737373),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.nameController,
                        hintText: "Enter your full name",
                        prefixIcon: Icons.person_2_outlined,
                      ),
                      SizedBox(height: 18),
                      Text(
                        "Email or Phone",
                        style: getTextStyle(
                          color: Color(0xFF737373),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.emailController,
                        hintText: "Enter your email or phone",
                        prefixIcon: Icons.email_outlined,
                      ),
                      SizedBox(height: 18),
                      Text(
                        "Enter Your Password",
                        style: getTextStyle(
                          color: Color(0xFF737373),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.passwordController,
                        hintText: "**************",
                        prefixIcon: Icons.lock_open_outlined,
                        isObscure: true,
                        suffixIcon: Icons.visibility_off,
                      ),
                      SizedBox(height: 18),
                      Text(
                        "Confirm Your Password",
                        style: getTextStyle(
                          color: Color(0xFF737373),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.confirmPasswordController,
                        hintText: "***************",
                        prefixIcon: Icons.email_outlined,
                      ),

                      SizedBox(height: 60),
                      CustomButton(
                        text: "Create account",
                        ontap: () {
                          controller.signUp();
                        },
                      ),
                      SizedBox(height: 60),

                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: getTextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF7D7D7D),
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: getTextStyle(
                                  color: Color(0xFFAA8D34),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAllNamed('/loginScreen');
                                  },
                              ),
                            ],
                          ),
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
