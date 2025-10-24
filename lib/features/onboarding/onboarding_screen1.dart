import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/common/widgets/custom_button.dart';
import 'package:pastor_lili/core/utils/constants/image_path.dart';
import 'package:pastor_lili/features/onboarding/onboarding_screen2.dart'
    show OnboardingScreen2;

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

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
                image: AssetImage(ImagePath.onboarding1image),
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
              "Find the right space for your event,\n meeting, or celebration, all in one place.",
              textAlign: TextAlign.center,
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              text: "Next",
              ontap: () {
                Get.to(OnboardingScreen2());
              },
            ),
          ),
        ],
      ),
    );
  }
}
