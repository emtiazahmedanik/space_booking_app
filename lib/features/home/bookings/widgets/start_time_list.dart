import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/home/bookings/controller/bookings_controller.dart'
    show BookingsController;

class StartTimeList extends StatelessWidget {
  StartTimeList({super.key});

  final BookingsController controller = Get.find<BookingsController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.startTime.length,
          itemBuilder: (context, index) {
            var time = controller.startTime[index];
            return GestureDetector(
              onTap: () {
                for (var t in controller.startTime) {
                  t['isSelected'] = false;
                }
                time['isSelected'] = true;
                controller.startTime.refresh(); // 👈 notify Obx
              },
              child: Container(
                margin: EdgeInsets.only(right: 12),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: time['isSelected']
                      ? AppColors.primaryColor
                      : Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  time['time'],
                  style: TextStyle(
                    color: time['isSelected'] ? Colors.white : Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
