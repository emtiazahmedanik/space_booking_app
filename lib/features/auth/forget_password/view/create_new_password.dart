import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/common/widgets/custom_button.dart';
import 'package:pastor_lili/core/common/widgets/custom_textfield.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/auth/forget_password/controller/forget_password_controller.dart';

class CreateNewPassword extends StatelessWidget {
  CreateNewPassword({super.key});
  final ForgetPasswordController controller =
      Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x00000008),
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        ),
                        BoxShadow(
                          color: Color(0x0000001A),
                          blurRadius: 4,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "Create New Password",
                  style: getTextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
              ],
            ),

            SizedBox(height: 40),
            Text(
              "Enter New Password",
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
              "Confirm Your New Password",
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

            Spacer(),
            CustomButton(
              text: "Continue",
              ontap: () {
                Get.offAllNamed('/loginScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
