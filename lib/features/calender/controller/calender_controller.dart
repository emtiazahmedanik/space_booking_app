import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pastor_lili/core/services/end_points.dart';
import 'package:pastor_lili/core/services/storage_service.dart';
import 'package:pastor_lili/features/calender/model/calender_model.dart';

class CalenderController extends GetxController {
  var selectedIndex = 0.obs;

  var upcomingBookings = <Booking>[].obs;
  var completedBookings = <Booking>[].obs;
  var pendingBookings = <Booking>[].obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void selectTab(int index) => selectedIndex.value = index;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      isLoading(true);
      errorMessage('');
      final token = StorageService.token;

      final response = await http.get(
        Uri.parse(Urls.getBookings),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 && response.statusCode == 201 ||
          response.body.isNotEmpty) {
        if (kDebugMode) {
          print(response.statusCode);
        }
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          final bookingsData = data['data'];

          upcomingBookings.assignAll(
            (bookingsData['upcoming'] as List)
                .map((b) => Booking.fromJson(b))
                .toList(),
          );

          completedBookings.assignAll(
            (bookingsData['completed'] as List)
                .map((b) => Booking.fromJson(b))
                .toList(),
          );

          pendingBookings.assignAll(
            (bookingsData['pending'] as List)
                .map((b) => Booking.fromJson(b))
                .toList(),
          );
        } else {
          errorMessage('Invalid response from server: ${response.statusCode}');
        }
      } else {
        errorMessage('Server error: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('Failed to fetch bookings: $e');
    } finally {
      isLoading(false);
    }
  }
}
