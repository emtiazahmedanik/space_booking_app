import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/common/widgets/custom_button.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/home/confirm_booking/controller/confirm_booking_controller.dart';
import 'package:pastor_lili/features/home/confirm_booking/widgets/date_and_time.dart'
    show DateAndTime;
import 'package:pastor_lili/features/home/confirm_booking/widgets/details_container.dart'
    show DetailsContainer;
import 'package:pastor_lili/features/home/confirm_booking/widgets/payment_details.dart'
    show PaymentDetails;
import 'package:pastor_lili/features/home/confirm_booking/widgets/payment_widget.dart'
    show PaymentWidget;

class ConfirmBookingView extends StatelessWidget {
  ConfirmBookingView({super.key});

  final ConfirmBookingController controller = Get.put(
    ConfirmBookingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reserve',
          style: getTextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              DetailsContainer(),
              SizedBox(height: 20),
              DateAndTime(),
              SizedBox(height: 30),
              Align(alignment: Alignment.bottomLeft, child: PaymentWidget()),
              SizedBox(height: 40),
              Align(alignment: Alignment.bottomLeft, child: PaymentDetails()),
              SizedBox(height: 50),
              CustomButton(
                text: "Confirm & Pay",
                ontap: () async {
                  await controller.makePayment();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
