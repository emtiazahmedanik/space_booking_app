import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/core/utils/constants/icon_path.dart';
import 'package:pastor_lili/features/home/bookings/controller/bookings_controller.dart';

class DurationWidget extends StatelessWidget {
  DurationWidget({super.key});

  final BookingsController controller = Get.find<BookingsController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            controller.decrementDuration();
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Image.asset(IconPath.minusIcon, width: 24, height: 24),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 78, vertical: 10),
            child: Obx(
              () => Text(
                "${controller.duration.value.toString()} hours",
                style: getTextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.incrementDuration();
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Image.asset(IconPath.plus, width: 24, height: 24),
          ),
        ),
      ],
    );
  }
}
