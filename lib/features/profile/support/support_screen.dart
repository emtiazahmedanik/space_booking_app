// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  // Open dialer or show fallback dialog
  Future<void> _openDialer(String phoneNumber, BuildContext context) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri, mode: LaunchMode.externalApplication);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Dialer Not Available"),
          content: Text("Cannot open the dialer.\nNumber: $phoneNumber"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  // Open email app
  Future<void> _openEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=App Support&body=Hello Pastor Lili Team,',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    const phoneNumber = "+8801234567890";
    const email = "support@pastorlili.com";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Support & Help",
          style: getTextStyle(color: Colors.white, fontSize: 17),
        ),
        backgroundColor: Color(0xFF6A1F75),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Text(
              "Need Help?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              "If you have any questions or face any issues while using our app, please contact our support team. We're here to help you 24/7.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            SizedBox(height: 25),

            ListTile(
              leading: Icon(Icons.email_outlined, color: Colors.purple),
              title: Text("Email Us"),
              subtitle: Text(email),
              onTap: () => _openEmail(email),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.phone, color: Colors.purple),
              title: Text("Call Us"),
              subtitle: Text(phoneNumber),
              onTap: () => _openDialer(phoneNumber, context),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.chat_bubble_outline, color: Colors.purple),
              title: Text("Live Chat"),
              subtitle: Text("Chat support coming soon"),
            ),
            Divider(),

            SizedBox(height: 30),
            Text(
              "Our support team is dedicated to ensuring your experience is smooth and enjoyable. You can also check our FAQs section for quick solutions.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
