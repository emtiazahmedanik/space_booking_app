import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/calender/controller/calender_controller.dart';
import 'package:pastor_lili/features/calender/widgets/calender_list_view.dart';

class CalenderView extends StatelessWidget {
  CalenderView({super.key});

  final CalenderController controller = Get.put(CalenderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Bookings",
                  style: getTextStyle(
                    color: const Color(0xFF1E1E1E),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tabs
            Obx(() {
              return Row(
                children: [
                  _buildTab("Upcoming", 0),
                  const SizedBox(width: 12),
                  _buildTab("Completed", 1),
                  const SizedBox(width: 12),
                  _buildTab("Pending", 2),
                ],
              );
            }),

            const SizedBox(height: 20),

            // Booking List
            Expanded(
              child: Obx(() {
                if (controller.selectedIndex.value == 0) {
                  return BookingListView(bookings: controller.upcomingBookings);
                } else if (controller.selectedIndex.value == 1) {
                  return BookingListView(
                    bookings: controller.completedBookings,
                  );
                } else {
                  return BookingListView(bookings: controller.pendingBookings);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final controller = Get.find<CalenderController>();
    final isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.selectTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF3C94A) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: isSelected
              ? null
              : Border.all(color: const Color(0xFF1E1E1E), width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: const Color(0xFF1E1E1E),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
