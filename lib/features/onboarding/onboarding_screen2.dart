import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:pastor_lili/core/common/widgets/custom_button.dart'
    show CustomButton;
import 'package:pastor_lili/core/utils/constants/image_path.dart'
    show ImagePath;

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagePath.onboarding2image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Clear guidelines, reviews, and contracts to keep your events safe and stress-free.",
              textAlign: TextAlign.center,
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              text: "Get Started",
              ontap: () {
                Get.offAllNamed('/loginScreen');
              },
            ),
          ),
        ],
      ),
    );
  }
}
