import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../model/places_model.dart';
import '../../../../core/services/space_service.dart';

class SpaceController extends GetxController {
  var spaces = <SpaceModel>[].obs;
  var isLoading = false.obs;
  RxnString ownerId = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchSpacesFromApi();
  }

  Future<void> fetchSpacesFromApi() async {
    debugPrint("inside ....");
    try {
      isLoading.value = true;
      final fetchedSpaces = await SpaceService.fetchSpaces();
      spaces.assignAll(fetchedSpaces);
      ownerId.value = fetchedSpaces.first.ownerId;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Failed to load spaces");
      debugPrint("❌ Error fetching spaces: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
