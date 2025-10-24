// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pastor_lili/core/services/end_points.dart';
import 'package:pastor_lili/core/services/storage_service.dart';

Future<void> createBooking({
  required String spaceId,
  required DateTime date,
  required String timeSlot,
  required int durationHours,
}) async {
  final url = Uri.parse(Urls.bookings);
  final parsedTime = DateFormat("hh:mm a").parse(timeSlot);

  final startTime = DateTime(
    date.year,
    date.month,
    date.day,
    parsedTime.hour,
    parsedTime.minute,
  );

  final endTime = startTime.add(Duration(hours: durationHours));

  final body = {
    'spaceId': spaceId,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
  };

  final token = StorageService.token;

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      EasyLoading.showToast("Pay now to confirm your booking");
      debugPrint('✅ Booking created successfully: $responseData');
    } else {
      debugPrint('❌ Booking failed: ${response.statusCode}');
      debugPrint('Response: ${response.body}');
    }
  } catch (e) {
    debugPrint('⚠️ Error while creating booking: $e');
  }
}
