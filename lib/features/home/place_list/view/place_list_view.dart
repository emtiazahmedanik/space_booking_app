import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/features/home/place_list/controller/place_list_controller.dart';
import 'package:pastor_lili/features/home/place_list/widgets/places.dart';
import 'package:pastor_lili/features/profile/my_profile/controller/profile_cotroller.dart';

import '../../../../core/utils/constants/colors.dart';

class PlaceListView extends StatelessWidget {
  PlaceListView({super.key});

  final SpaceController controller = Get.put(SpaceController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      "Hi ${shortenName(profileController.fullName.value)}, Good Morning ✨",
                      style: getTextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                "Browse and book from our available spaces today.",
                style: getTextStyle(
                  color: Color(0xFF7D7D7D),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Our Places",
                style: getTextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Places();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String shortenName(String name, {int maxLength = 5}) {
  if (name.length <= maxLength) return name;
  // Cut back to nearest word boundary
  final trimmed = name.substring(0, maxLength);
  final lastSpace = trimmed.lastIndexOf(' ');
  return '${(lastSpace > 0 ? trimmed.substring(0, lastSpace) : trimmed).trim()}..';
}
