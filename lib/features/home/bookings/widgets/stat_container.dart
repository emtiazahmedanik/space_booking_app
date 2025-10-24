import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/features/home/bookings/controller/bookings_controller.dart';

class StatContainer extends StatelessWidget {
  StatContainer({super.key});

  final BookingsController controller = Get.find<BookingsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF0E9F1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFC2A3C6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                "Selected: ${controller.selectedDatesText}, ${controller.selectedStartTime}",
                style: getTextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 16),
            Obx(
              () => Text(
                "Duration: ${controller.duration.value.toString()} hours",
                style: getTextStyle(
                  color: Color(0xFF716E6E),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Advance Payment (20%): \$24",
              style: getTextStyle(
                color: Color(0xFF2D2D2D),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Diposit Amount (Refundable): \$100",
              style: getTextStyle(
                color: Color(0xFF2D2D2D),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
