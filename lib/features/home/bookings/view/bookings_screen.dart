import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/common/widgets/custom_button.dart';
import 'package:pastor_lili/core/services/bookings_Service.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/home/bookings/controller/bookings_controller.dart';
import 'package:pastor_lili/features/home/bookings/widgets/duration_widget.dart'
    show DurationWidget;
import 'package:pastor_lili/features/home/bookings/widgets/start_time_list.dart'
    show StartTimeList;
import 'package:pastor_lili/features/home/bookings/widgets/stat_container.dart'
    show StatContainer;
import 'package:pastor_lili/features/home/confirm_booking/view/confirm_booking_view.dart'
    show ConfirmBookingView;
import 'package:pastor_lili/features/home/place_list/model/places_model.dart';

class BookingsScreen extends StatelessWidget {
  BookingsScreen({super.key});

  final BookingsController controller = Get.put(BookingsController());

  final SpaceModel spaceModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    debugPrint(spaceModel.spaceId);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Select Date & Time',
          style: getTextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: CalendarCarousel(
                  iconColor: Colors.black,
                  todayButtonColor: Colors.transparent,
                  todayBorderColor: Colors.transparent,
                  selectedDayBorderColor: Colors.transparent,
                  thisMonthDayBorderColor: Colors.transparent,
                  customDayBuilder:
                      (
                        bool isSelectable,
                        int index,
                        bool isSelectedDay,
                        bool isToday,
                        bool isPrevMonthDay,
                        TextStyle textStyle,
                        bool isNextMonthDay,
                        bool isThisMonthDay,
                        DateTime day,
                      ) {
                        bool isSelected = controller.selectedDates.any(
                          (d) =>
                              d.year == day.year &&
                              d.month == day.month &&
                              d.day == day.day,
                        );

                        if (isSelected) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${day.day}',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        if (isToday) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        return null; // Use default rendering
                      },
                  onDayPressed: (date, events) {
                    controller.onDateSelected(date);
                  },
                  daysHaveCircularBorder: false,
                  weekdayTextStyle: TextStyle(color: Colors.black),
                  weekendTextStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 36),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Start Time",
                  style: getTextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 16),
              StartTimeList(),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Duration",
                  style: getTextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 16),
              DurationWidget(),
              SizedBox(height: 24),
              StatContainer(),
              SizedBox(height: 30),
              CustomButton(
                text: "Continue",
                ontap: () {
                  if (controller.selectedDates.isEmpty) {
                    EasyLoading.showError('Please Select a Date');
                    return;
                  }

                  final selectedDate = controller.selectedDates.first;
                  // Replace 'yourData' with the actual variable holding your booking data

                  createBooking(
                    spaceId: spaceModel.spaceId,
                    date: selectedDate,
                    timeSlot: controller.selectedStartTime,
                    durationHours: controller.duration.value,
                  );

                  Get.to(() => ConfirmBookingView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
