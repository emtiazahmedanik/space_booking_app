import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/common/widgets/custom_button.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../bookings/view/bookings_screen.dart';
import '../../../../core/services/end_points.dart';
import '../controller/place_list_controller.dart';

class Places extends StatelessWidget {
  Places({super.key});

  final SpaceController controller = Get.find<SpaceController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.spaces.isEmpty) {
        return Center(child: Text("No spaces available right now."));
      }

      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.spaces.length,
        itemBuilder: (context, index) {
          final space = controller.spaces[index];
          final imageUrl = space.images.isNotEmpty
              ? '${Urls.baseUrl}/${space.images[0]}'
              : 'https://via.placeholder.com/300x200?text=No+Image';

          return Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: () => Get.toNamed('/placeDetailsScreen', arguments: space),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      blurRadius: 7,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 160,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 160,
                          color: Colors.grey[200],
                          alignment: Alignment.center,
                          child: Icon(Icons.broken_image, size: 40),
                        ),
                      ),
                    ),

                    // Info
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  space.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: getTextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFAE9B5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                child: Text(
                                  '${space.capacity}+ people',
                                  style: getTextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            space.description,
                            style: getTextStyle(
                              color: Color(0xFF7D7D7D),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Price: \$${space.price}/hr",
                            style: getTextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 16),
                          CustomButton(
                            text: "Book Now",
                            ontap: () {
                              Get.to(() => BookingsScreen(), arguments: space);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
