// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import '../controller/payment_controller.dart';

class PaymentMethodScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Payment Methods",
          style: getTextStyle(color: AppColors.primaryColor, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                "Select a Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),

              ListTile(
                leading: Icon(Icons.credit_card, color: Colors.blueAccent),
                title: Text("Credit/Debit Card (Stripe)"),
                trailing: Radio<String>(
                  value: "stripe",
                  groupValue: controller.selectedMethod.value,
                  onChanged: (val) {
                    controller.selectedMethod.value = val!;
                  },
                ),
              ),
              Divider(),

              SizedBox(height: 100),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6A1F75).withValues(alpha: .85),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: controller.isProcessing.value
                      ? null
                      : () async {
                          if (controller.selectedMethod.value == "stripe") {
                            await controller.makePayment();
                          } else {
                            EasyLoading.showError(
                              "Please select Stripe method",
                            );
                          }
                        },
                  child: controller.isProcessing.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Pay Now",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }
}
