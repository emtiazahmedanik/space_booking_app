import 'dart:io' show File;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pastor_lili/core/services/profile_services.dart';
import 'package:pastor_lili/features/profile/my_profile/model/new_profile_model.dart';
import 'package:pastor_lili/features/profile/my_profile/model/profile_option_model.dart';
import '../../../../core/utils/constants/icon_path.dart';

class ProfileController extends GetxController {
  var profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  var fullName = ''.obs;
  var email = ''.obs;
  RxnString avatar = RxnString();
  var role = ''.obs;
  var isLoading = false.obs;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking image: $e");
      }
    }
  }

  Future<void> fetchProfileData() async {
    isLoading.value = true;
    try {
      final NewProfileModel data = await ProfileServices().getProfile();
      debugPrint("Profile Email${data.email}");

      fullName.value = data.fullName ;
      email.value = data.email ;
      avatar.value = data.avatar ;
      role.value = data.role ;
    } catch (e) {
      if (kDebugMode) {
        print("Profile fetch error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfileData(); 
  }

  final List<ProfileOptionModel> profileOptions = [
    ProfileOptionModel(
      title: "Payment Methods",
      iconPath: IconPath.paymentIcon,
    ),
    ProfileOptionModel(
      title: "Community Guidelines",
      iconPath: IconPath.communityIcon,
    ),
    ProfileOptionModel(
      title: "Support & Help",
      iconPath: IconPath.supportIcon,
    ),
    ProfileOptionModel(
      title: "About",
      iconPath: IconPath.aboutIcon,
    ),
  ];
}
