import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pastor_lili/core/common/widgets/custom_button.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/calender/controller/calender_controller.dart';
import 'package:pastor_lili/features/calender/model/calender_model.dart';

class BookingListView extends StatelessWidget {
  final RxList<Booking> bookings;
  final CalenderController controller = Get.find<CalenderController>();

  BookingListView({super.key, required this.bookings});

  String formatDate(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      return DateFormat('EEE, MMM d · hh:mm a').format(dt);
    } catch (e) {
      return isoDate;
    }
  }

  Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return Colors.green.shade100;
      case 'COMPLETED':
        return Colors.green;
      case 'PENDING':
        return Colors.yellow.shade200;
      default:
        return Colors.grey.shade300;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return Colors.green;
      case 'COMPLETED':
        return Colors.white;
      case 'PENDING':
        return Colors.black87;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }
      if (bookings.isEmpty) {
        return const Center(child: Text("No bookings found."));
      }

      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          final image = booking.space.images.isNotEmpty
              ? booking.space.images.first
              : 'https://via.placeholder.com/150';

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: .3),
                    blurRadius: 7,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.space.title,
                          style: getTextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Start: ${formatDate(booking.startTime)}",
                          style: getTextStyle(fontSize: 12),
                        ),
                        Text(
                          "End: ${formatDate(booking.endTime)}",
                          style: getTextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Charges: \$${booking.amount.toStringAsFixed(2)}",
                          style: getTextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: getStatusColor(booking.status),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          child: Text(
                            booking.status,
                            style: TextStyle(
                              color: getStatusTextColor(booking.status),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        CustomButton(
                          text: "Leave a Review",
                          ontap: () {
                            //Todo: Add logic of review
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
