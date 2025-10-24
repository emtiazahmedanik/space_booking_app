import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentController extends GetxController {
  var isProcessing = false.obs;
  var selectedMethod = ''.obs;

  // Replace with your backend endpoint that creates PaymentIntent
  final String backendUrl = "https://your-backend.com/create-payment-intent";

  Future<void> makePayment() async {
    try {
      isProcessing.value = true;

      // 1️⃣ Create PaymentIntent on your backend
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': 2000, 'currency': 'usd'}), // $20.00
      );

      final paymentIntentData = jsonDecode(response.body);

      // 2️⃣ Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['clientSecret'],
          merchantDisplayName: 'My Shop',
          style: ThemeMode.dark,
        ),
      );

      // 3️⃣ Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      Get.snackbar("Success", "Payment completed!");
    } catch (e) {
      Get.snackbar("Payment Failed", e.toString());
    } finally {
      isProcessing.value = false;
    }
  }
}
