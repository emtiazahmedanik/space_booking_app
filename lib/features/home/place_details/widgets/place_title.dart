import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/features/home/place_details/controller/place_details_controller.dart';
import 'package:pastor_lili/features/home/place_list/model/places_model.dart';

class PlaceTitle extends StatelessWidget {
  PlaceTitle({super.key, required this.spaceModel});

  final PlaceDetailsController controller = Get.find<PlaceDetailsController>();
  final SpaceModel spaceModel;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final space = controller.spaces.isNotEmpty ? controller.spaces.first : null;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  spaceModel.title,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(
                    color: const Color(0xFF1E1E1E),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFAE9B5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    space != null
                        ? 'Up to ${spaceModel.capacity} people'
                        : 'Loading...',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
      
          Text(
            spaceModel.subTitle,
            style: getTextStyle(
              color: const Color(0xFF7D7D7D),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    });
  }
}
