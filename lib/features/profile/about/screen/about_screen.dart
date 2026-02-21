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
              "Pastor Lili Spaces is a modern mobile platform designed to make renting community spaces effortless. Whether you're planning a meeting, event, class, or celebration — we help you find the right space at the right time.",
              style: getTextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "The Problem We Solve",
              style: getTextStyle(
                color: Color(0xFF6A1F75),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Finding and booking a community space has traditionally been a frustrating experience — scattered listings, unclear availability, manual paperwork, and unreliable payment processes. Pastor Lili Spaces eliminates these pain points by bringing everything into one seamless app:",
              style: getTextStyle(color: Colors.black54, fontSize: 14),
            ),
            SizedBox(height: 8),
            buildBullet("Browse verified spaces with photos, amenities, and pricing in one place."),
            buildBullet("Check real-time availability and book by the hour."),
            buildBullet("Pay securely online — no cash, no hassle."),
            buildBullet("Manage all your bookings and history from a single dashboard."),
            buildBullet("Communicate instantly with space owners via in-app chat."),
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
              "Technologies Used",
              style: getTextStyle(
                color: Color(0xFF6A1F75),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            buildBullet("Flutter — cross-platform mobile framework for iOS & Android."),
            buildBullet("GetX — lightweight state management, routing, and dependency injection."),
            buildBullet("Firebase Auth — secure user authentication with email/password and Google Sign-In."),
            buildBullet("REST API (HTTP) — backend communication for spaces, bookings, and user data."),
            buildBullet("Socket.IO — real-time bidirectional messaging for in-app chat."),
            buildBullet("Google Fonts & Flutter ScreenUtil — consistent, responsive UI design."),
            SizedBox(height: 20),
            Text(
              "Payment System",
              style: getTextStyle(
                color: Color(0xFF6A1F75),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "All payments in Pastor Lili Spaces are powered by Stripe — one of the world's most trusted payment platforms. Stripe provides:",
              style: getTextStyle(color: Colors.black54, fontSize: 14),
            ),
            SizedBox(height: 8),
            buildBullet("PCI-DSS compliant card processing for maximum security."),
            buildBullet("Native Stripe Payment Sheet for a smooth, familiar checkout experience."),
            buildBullet("Support for major credit and debit cards."),
            buildBullet("Secure PaymentIntent flow — card details never touch our servers."),
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
              "We appreciate your trust in Pastor Lili Spaces. Together, we're creating a community built on trust, respect, and opportunity.",
              style: getTextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
