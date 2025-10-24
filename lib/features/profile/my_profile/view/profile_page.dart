import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/features/profile/about/screen/about_screen.dart';
import 'package:pastor_lili/features/profile/community/screen/community_screen.dart';
import 'package:pastor_lili/features/profile/my_profile/controller/profile_cotroller.dart';
import 'package:pastor_lili/features/profile/my_profile/widgets/profile_appbar.dart';
import 'package:pastor_lili/features/profile/support/support_screen.dart';
import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../../payment/screen/payment_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController(), permanent: true);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: ProfileAppbar(controller: controller),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Obx(() {
                      final image = controller.avatar.value;
                      return image != null
                          ? Image.network(
                              image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              ImagePath.profilePicture,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            );
                    }),
                  ),
                ),

                const SizedBox(height: 16),

                Column(
                  children: [
                    Text(
                      controller.fullName.value.isNotEmpty
                          ? controller.fullName.value
                          : "Loading name...",
                      style: getTextStyle(
                        color: const Color(0xFF1E1E1E),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      controller.email.value.isNotEmpty
                          ? controller.email.value
                          : "Loading email...",
                      style: getTextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),
                Divider(color: Colors.grey.shade400),
                const SizedBox(height: 32),

                // 🔹 Profile Options
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.profileOptions.length,
                  itemBuilder: (_, index) {
                    final item = controller.profileOptions[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          switch (item.title) {
                            case "Payment Methods":
                              Get.to(() => PaymentMethodScreen());
                              break;
                            case "Community Guidelines":
                              Get.to(() => CommunityGuidelinesScreen());
                              break;
                            case "About":
                              Get.to(() => const AboutScreen());
                              break;
                            case "Support & Help":
                              Get.to(() => const SupportScreen());
                              break;
                            default:
                              break;
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  item.iconPath,
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  item.title,
                                  style: getTextStyle(
                                    color: const Color(0xFF1E1E1E),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
