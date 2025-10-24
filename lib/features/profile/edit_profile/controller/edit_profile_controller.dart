import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pastor_lili/core/services/profile_services.dart';
import 'package:pastor_lili/features/profile/my_profile/controller/profile_cotroller.dart';

class EditProfileController extends GetxController {
  var profileImage = Rx<File?>(null);
  var isLoading = false.obs;
  final ProfileController profileController = Get.put(ProfileController());

  final ImagePicker _picker = ImagePicker();
  RxnString imageUrl = RxnString();
  late TextEditingController fullNameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void onInit() {
    fullNameController = TextEditingController(text: 'Wade Warren');
    usernameController = TextEditingController(text: '@Cliixx');
    emailController = TextEditingController(text: 'example@gmail.com');
    phoneController = TextEditingController(text: '+1 234 567 890');
    super.onInit();
    setProfileImage();
  }

  void setProfileImage() {
    imageUrl = profileController.avatar;
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  Future<void> saveChanges() async {
    try {
      isLoading.value = true;

      final fullName = fullNameController.text.trim();

      final data = await ProfileServices().updateProfile(
        fullName: fullName,
        avatar: profileImage.value,
      );

      // Here call the function getProfile so that the global name and email can be changed
      if (data != null) {
        final updatedUser = await ProfileServices().getProfile();
        profileController.email.value = updatedUser.email;
        profileController.fullName.value = updatedUser.fullName;
        profileController.avatar.value = updatedUser.avatar;
        fullNameController.text = updatedUser.fullName;
        imageUrl = profileController.avatar;

        EasyLoading.showSuccess('Profile updated successfully');

        Get.back();
      }
    } catch (e) {
      EasyLoading.showError('Failed to update profile');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
