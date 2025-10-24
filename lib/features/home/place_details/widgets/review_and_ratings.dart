import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/utils/constants/icon_path.dart';
import 'package:pastor_lili/features/home/place_details/controller/place_details_controller.dart';

class ReviewAndRatings extends StatelessWidget {
  ReviewAndRatings({super.key});

  final PlaceDetailsController controller = Get.find<PlaceDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reviews & Ratings",
              style: getTextStyle(
                color: Color(0xFF444444),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Image.asset(IconPath.starIcon, height: 14, width: 14),
                SizedBox(width: 8),
                Text(
                  "4.8 (32 reviews)",
                  style: getTextStyle(
                    color: Color(0xFF444444),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 14),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: controller.reviews.length,
            itemBuilder: (context, index) {
              var review = controller.reviews[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x42000000),
                        offset: Offset(0, 0),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            review['profile'] ?? IconPath.profileIcon,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          // 🔥 This prevents overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review['name'] ?? 'User Name',
                                    style: getTextStyle(
                                      color: Color(0xFF444444),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        IconPath.starIcon,
                                        width: 14,
                                        height: 14,
                                      ),
                                      SizedBox(width: 6),

                                      Text(
                                        review['rating']?.toString() ?? '0.0',
                                        style: getTextStyle(
                                          color: Color(0xFF444444),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                review['comment'] ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: getTextStyle(
                                  color: Color(0xFF7D7D7D),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
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
          ),
        ),
      ],
    );
  }
}
