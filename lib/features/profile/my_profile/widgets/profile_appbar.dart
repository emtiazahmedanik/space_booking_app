import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/profile/edit_profile/screen/edit_profile_screen.dart';
import 'package:pastor_lili/features/profile/my_profile/controller/profile_cotroller.dart';
import 'package:pastor_lili/features/profile/my_profile/widgets/delete_account_dialogue.dart';

import '../../../../core/services/storage_service.dart';

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppbar({super.key, required this.controller});

  final ProfileController controller;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,

      title: Text(
        "Profile",
        style: getTextStyle(
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,

      // 👇 Added 3-dot menu icon here
      actions: [
        PopupMenuButton<String>(
          color: Colors.purple,
          icon: const Icon(Icons.more_vert, color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (value) async {
            switch (value) {
              case 'Edit Profile':
                Get.to(() => EditProfileScreen());
                break;

              case 'Logout':
                await StorageService.logoutUser();
                Get.offAllNamed('/loginScreen');

                break;

              case 'Delete Account':
                showDeleteAccountDialog(context);
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'Edit Profile',
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            PopupMenuItem(
              value: 'Logout',
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            PopupMenuItem(
              value: 'Delete Account',
              child: Text(
                'Delete Account',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
