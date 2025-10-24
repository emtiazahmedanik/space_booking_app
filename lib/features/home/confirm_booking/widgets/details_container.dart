import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/utils/constants/icon_path.dart';
import 'package:pastor_lili/core/utils/constants/image_path.dart';
import 'package:pastor_lili/features/home/confirm_booking/controller/confirm_booking_controller.dart';

class DetailsContainer extends StatelessWidget {
  DetailsContainer({super.key});

  final ConfirmBookingController controller =
      Get.find<ConfirmBookingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFE9E9E9), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 88,
              height: 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.place1),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Commercial Kitchen",
                  style: getTextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 215,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$120 for 3 hrs",
                        style: getTextStyle(
                          color: Color(0xFF444444),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(IconPath.starIcon, width: 14, height: 14),
                          SizedBox(width: 2),
                          Text(
                            "4.8",
                            style: getTextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
