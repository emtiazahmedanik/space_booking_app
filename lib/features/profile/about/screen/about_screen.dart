import 'package:flutter/material.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';

import '../widgets/about_bullet.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Color(0xFF6A1F75),
        title: Text(
          "About Us",
          style: getTextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Pastor Lili Spaces",
              style: getTextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Pastor Lili Spaces is a modern platform designed to make renting community spaces effortless. Whether you’re planning a meeting, event, class, or celebration — we help you find the right space at the right time.",
              style: getTextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Our Mission",
              style: getTextStyle(
                color: Color(0xFF6A1F75),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We aim to connect communities by making space sharing simple, transparent, and affordable. Every available space should be accessible to those who need it — with trust and convenience at the heart of every booking.",
              style: getTextStyle(color: Colors.black54, fontSize: 14),
            ),
            SizedBox(height: 20),
            Text(
              "What We Offer",
              style: getTextStyle(
                color: Color(0xFF6A1F75),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            buildBullet("Easy booking and secure payments."),
            buildBullet("Verified spaces with real images."),
            buildBullet("Flexible rental options by the hour."),
            buildBullet("Responsive support team."),
            SizedBox(height: 20),
            Text(
              "Thank You",
              style: getTextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We appreciate your trust in Pastor Lili Spaces. Together, we’re creating a community built on trust, respect, and opportunity.",
              style: getTextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
