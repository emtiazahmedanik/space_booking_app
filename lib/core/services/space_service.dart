import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pastor_lili/core/services/end_points.dart';
import 'package:pastor_lili/core/services/storage_service.dart';

import '../../features/home/place_list/model/places_model.dart';

class SpaceService {
  static Future<List<SpaceModel>> fetchSpaces() async {
    final token = StorageService.token;
    final bearerToken = "Bearer $token";

    final url = Uri.parse(Urls.getSpaces);
    final headers = {"Authorization": bearerToken};

    final response = await http.get(url, headers: headers);
    debugPrint("🟢 Response status: ${response.statusCode}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final data = decoded["data"] as List;
      return data.map((e) => SpaceModel.fromJson(e)).toList();
    } else {
      throw Exception(
        "Failed to fetch spaces: ${response.statusCode} ${response.body}",
      );
    }
  }
}
