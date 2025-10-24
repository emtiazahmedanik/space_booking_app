import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/common/widgets/custom_button.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/core/utils/constants/image_path.dart';
import 'package:pastor_lili/features/auth/forget_password/controller/forget_password_controller.dart';
import 'package:pastor_lili/features/auth/forget_password/view/enter_phone_screen.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  final ForgetPasswordController controller = Get.put(
    ForgetPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Center(
          child: Column(
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
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 196,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(ImagePath.forgetPasswordContainer),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.selectOption(1);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 108,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: controller.isSelected(1)
                            ? AppColors.primaryColor
                            : Color(0xFFD9D9D9),
                      ),
                      image: DecorationImage(
                        image: AssetImage(ImagePath.phoneSMS),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.selectOption(2);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 108,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: controller.isSelected(2)
                            ? AppColors.primaryColor
                            : Color(0xFFD9D9D9),
                      ),
                      image: DecorationImage(
                        image: AssetImage(ImagePath.emailSMS),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              CustomButton(
                text: "Continue",
                ontap: () {
                  Get.to(EnterPhoneScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
