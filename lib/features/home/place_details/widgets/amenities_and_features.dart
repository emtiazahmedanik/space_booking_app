import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/features/home/place_details/controller/place_details_controller.dart';
import 'package:pastor_lili/features/home/place_list/model/places_model.dart';

class AmenitiesAndFeatures extends StatelessWidget {
  AmenitiesAndFeatures({super.key, required this.spaceModel});

  final SpaceModel spaceModel;
  final PlaceDetailsController controller = Get.find<PlaceDetailsController>();

  @override
  Widget build(BuildContext context) {
    final List<String> amenities = spaceModel.amenities;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Amenities & Features",
          style: getTextStyle(
            color: const Color(0xFF444444),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 60,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: amenities.map((amenity) {
              final normalizedKey = amenity.toString().trim().toUpperCase();

              final iconData = controller.amenityIcons[normalizedKey];

              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      iconData?['icon'] ?? 'assets/icons/default_icon.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      iconData?['label'] ?? amenity,
                      style: getTextStyle(
                        color: const Color(0xFF1E1E1E),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
