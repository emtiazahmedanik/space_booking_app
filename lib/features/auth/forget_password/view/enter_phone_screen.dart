import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:pastor_lili/core/common/widgets/custom_button.dart';
import 'package:pastor_lili/core/common/widgets/custom_textfield.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/auth/forget_password/controller/forget_password_controller.dart';
import 'package:pastor_lili/features/auth/forget_password/view/otp_screen.dart';

class EnterPhoneScreen extends StatelessWidget {
  EnterPhoneScreen({super.key});

  final ForgetPasswordController controller =
      Get.find<ForgetPasswordController>();

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
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
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
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Forgot Password",
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
                        "Email or Phone",
                        style: getTextStyle(
                          color: Color(0xFF737373),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.emailorPhoneController,
                        hintText: "Enter your email or phone",
                        prefixIcon: Icons.email_outlined,
                      ),
                      Spacer(),
                      CustomButton(
                        text: "Submit",
                        ontap: () {
                          Get.to(OtpScreen());
                        },
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
