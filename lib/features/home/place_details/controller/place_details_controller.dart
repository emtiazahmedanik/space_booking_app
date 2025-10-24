import 'package:get/get.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../place_list/model/places_model.dart';
import '../../../../core/services/space_service.dart';



class PlaceDetailsController extends GetxController {
    var spaces = <SpaceModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpacesFromApi();
  }

  Future<void> fetchSpacesFromApi() async {
    try {
      isLoading.value = true;
      EasyLoading.show(status: "Loading spaces...");
      final fetchedSpaces = await SpaceService.fetchSpaces();
      spaces.assignAll(fetchedSpaces);

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Failed to load spaces");
      debugPrint("❌ Error fetching spaces: $e");
    } finally {
      isLoading.value = false;
    }
  }
  List<Map<String, dynamic>> pictures = [
    {'image': 'assets/images/place1.png'},
    {'image': 'assets/images/place2.png'},
    {'image': 'assets/images/place3.png'},
    {'image': 'assets/images/place4.png'},
  ];

  var amenities = <Map<String, String>>[].obs;
  
  final Map<String, Map<String, String>> amenityIcons = {
      "WIFI": {
        "icon": "assets/icons/wifiIcon.png",
        "label": "Wi-Fi",
      },
      "PARKING_AVAILABLE": {
        "icon": "assets/icons/parkingIcon.png",
        "label": "Parking",
      },
      "AIR_CONDITIONING": {
        "icon": "assets/icons/acIcon.png",
        "label": "Air Conditioning",
      },
    };


  List<Map<String, dynamic>> reviews = [
    {
      'profile': 'assets/icons/profileIcon.jpg',
      'name': 'Sarah J.',
      'rating': 4.5,
      'comment':
          'Perfect kitchen setup for our cooking workshop! Clean and well-stocked.',
    },
    {
      'profile': 'assets/icons/profileIcon.jpg',
      'name': 'Sarah J.',
      'rating': 4.5,
      'comment':
          'Perfect kitchen setup for our cooking workshop! Clean and well-stocked.',
    },
    {
      'profile': 'assets/icons/profileIcon.jpg',
      'name': 'Sarah J.',
      'rating': 4.5,
      'comment':
          'Perfect kitchen setup for our cooking workshop! Clean and well-stocked.',
    },
  ];
}
