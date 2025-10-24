// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ConfirmBookingController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent('20', 'USD');
      if (paymentIntentData == null) return;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'PastorLili',
        ),
      );

      await displayPaymentSheet();
    } catch (e) {
      if (kDebugMode) {
        print('Exception during payment: $e');
      }
      EasyLoading.showError('Payment Failed');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      EasyLoading.showSuccess(
        'Payment Success'
        'Thank you for your payment!',
      );
      paymentIntentData = null;
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('StripeException: $e');
      }
      EasyLoading.showError('Payment Cancelled, You cancelled the payment');
    } catch (e) {
      if (kDebugMode) {
        print('Unhandled Exception: $e');
      }
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'STRIPE_SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print('Exception while creating PaymentIntent: $e');
      }
      return null;
    }
  }

  String calculateAmount(String amount) {
    final price = (int.parse(amount) * 100).toString();
    return price;
  }
}
