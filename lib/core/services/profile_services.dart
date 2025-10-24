import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:pastor_lili/core/services/end_points.dart';
import 'package:pastor_lili/core/services/storage_service.dart';
import 'package:pastor_lili/features/profile/my_profile/model/new_profile_model.dart';

class ProfileServices {
  Future<NewProfileModel> getProfile() async {
    final token = StorageService.token;

    if (token == null || token.isEmpty) {
      EasyLoading.showError('Token missing');
      throw Exception('Token missing');
    }

    try {
      final response = await http.get(
        Uri.parse(Urls.getProfile),
        headers: {'Authorization': 'Bearer $token', 'accept': '*/*'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint("ProfileResponse$data");
        NewProfileModel model = NewProfileModel.fromJson(data['data']);
        debugPrint("model is: ${model.email}");
        return model;
      } else {
        EasyLoading.showError('Failed to fetch profile');
        debugPrint("ProfileFetchFailed");

        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      if (kDebugMode) print("Profile error: $e");
      rethrow;
    }
  }

  Future<String?> updateProfile({
    required String fullName,
    File? avatar,
  }) async {
    final token = StorageService.token;

    if (token == null || token.isEmpty) {
      throw Exception('Token missing');
    }

    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(Urls.getProfile));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['accept'] = '*/*';

      request.fields['fullName'] = fullName;

      if (avatar != null) {
        request.files.add(
          await http.MultipartFile.fromPath('file', avatar.path),
        );
      }

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseBody;
      } else {
        if (kDebugMode) {
          print('Update failed: $responseBody');
        }
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Profile update error: $e");
      }
      rethrow;
    }
  }
}
