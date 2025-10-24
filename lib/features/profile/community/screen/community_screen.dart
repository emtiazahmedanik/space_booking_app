import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';

import '../widgets/community_bullet.dart';

class CommunityGuidelinesScreen extends StatelessWidget {
  final RxBool isExpanded = false.obs;

  CommunityGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          "Community Guidelines",
          style: getTextStyle(color: Colors.white, fontSize: 17),
        ),
        backgroundColor: Color(0xFF6A1F75),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Our Community!",
                style: getTextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "We’re glad to have you here. To maintain a positive and respectful environment, please take a moment to review our community guidelines.",
                style: getTextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),

              Text(
                "General Rules",
                style: getTextStyle(
                  color: Color(0xFF6A1F75),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              buildBullet("Be respectful towards others and their opinions."),
              buildBullet("Do not share offensive or inappropriate content."),
              buildBullet("Protect others’ privacy and personal data."),
              buildBullet(
                "Avoid spamming, self-promotion, or misleading information.",
              ),
              SizedBox(height: 20),

              Text(
                "Safety & Conduct",
                style: getTextStyle(
                  color: Color(0xFF6A1F75),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              buildBullet(
                "Report any suspicious or harmful behavior immediately.",
              ),
              buildBullet("Follow all applicable laws and platform policies."),
              buildBullet("Use respectful language in all interactions."),
              SizedBox(height: 20),

              Text(
                "Enforcement",
                style: getTextStyle(
                  color: Color(0xFF6A1F75),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              buildBullet(
                "Violations may lead to temporary or permanent suspension.",
              ),
              buildBullet(
                "Repeated misconduct will result in account termination.",
              ),
              buildBullet(
                "Admins reserve the right to remove inappropriate content.",
              ),
              SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  isExpanded.value = !isExpanded.value;
                },
                child: Row(
                  children: [
                    Icon(
                      isExpanded.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: Color(0xFF6A1F75),
                    ),
                    Text(
                      "Read More",
                      style: getTextStyle(
                        color: Color(0xFF6A1F75),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              if (isExpanded.value) ...[
                SizedBox(height: 12),
                Text(
                  "We believe that every member plays a vital role in maintaining a friendly, inclusive, and trustworthy space. By following these guidelines, you help ensure a positive experience for everyone. Thank you for being part of our community!",
                  style: getTextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],

              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6A1F75),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Got it",
                    style: getTextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
