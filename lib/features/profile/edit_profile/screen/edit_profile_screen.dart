import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/widgets/edit_custom_text_field.dart';
import 'package:pastor_lili/features/profile/edit_profile/controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Edit Profile"),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Profile Image Section
                Center(
                  child: Stack(
                    children: [
                      Obx(() {
                        return CircleAvatar(
                          radius: 50.r,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: controller.imageUrl.value != null
                              ? NetworkImage(controller.imageUrl.value!)
                              : const AssetImage(
                                      'assets/images/default_profile.png',
                                    )
                                    as ImageProvider,
                        );
                      }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: controller.pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                // 🔹 Input fields
                EditCustomTextField(
                  controller: controller.fullNameController,
                  lebelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
                SizedBox(height: 12.h),

                EditCustomTextField(
                  controller: controller.usernameController,
                  lebelText: 'Username',
                  hintText: 'Enter username',
                ),
                SizedBox(height: 12.h),

                EditCustomTextField(
                  controller: controller.phoneController,
                  lebelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                ),
                SizedBox(height: 30.h),

                // 🔹 Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () async => await controller.saveChanges(),

                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Save Changes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
