import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:pastor_lili/core/common/widgets/custom_button.dart'
    show CustomButton;
import 'package:pastor_lili/features/auth/forget_password/controller/forget_password_controller.dart';
import 'package:pastor_lili/features/auth/forget_password/view/create_new_password.dart'
    show CreateNewPassword;

import '../../../../core/utils/constants/colors.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final ForgetPasswordController controller =
      Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    controller.startTimer();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 50, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration:  BoxDecoration(
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
                      child:  Icon(
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

              Align(
                alignment: Alignment.center,
                child: Text(
                  "Code has been sent to +1 111 ******99",
                  style: getTextStyle(
                    color:  Color(0xFF737373),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(height: 24),
              OtpTextField(
                numberOfFields: 4,
                borderColor: Color(0xFFAFAFAF),
                focusedBorderColor: Color(0xFFAA8D34),
                cursorColor: Color(0xFFAA8D34),
                showFieldAsBox: true,
                borderWidth: 1,
                mainAxisAlignment: MainAxisAlignment.center,
                fieldWidth: 64,
                fieldHeight: 52,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFFAFAFAF), width: 1),
                  ),
                ),
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFAA8D34),
                  fontWeight: FontWeight.w600,
                ),
                onSubmit: (String code) {
                  debugPrint("OTP is => $code");
                },
              ),

              SizedBox(height: 20),

              /// Timer / Resend
              Align(
                alignment: Alignment.center,
                child: Obx(() {
                  if (controller.isResendAvailable.value) {
                    return TextButton(
                      onPressed: controller.resendCode,
                      child: Text(
                        "Resend",
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:  Color(0xFFAA8D34),
                        ),
                      ),
                    );
                  } else {
                    return RichText(
                      text: TextSpan(
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color:  Color(0xFFA3A3A3),
                        ),
                        children: [
                           TextSpan(text: "Resend code in "),
                          TextSpan(
                            text: "${controller.secondsRemaining.value}s",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:  Color(0xFFAA8D34),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ),

              Spacer(),

              /// Submit Button
              CustomButton(
                text: "Submit",
                ontap: () {
                  Get.to(CreateNewPassword());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
