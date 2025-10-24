import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/features/home/place_details/controller/place_details_controller.dart';

class ImagesList extends StatelessWidget {
  ImagesList({super.key});

  final PlaceDetailsController controller = Get.find<PlaceDetailsController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double spacing = 15;
    int itemCount = controller.pictures.length;

    // total spacing = (itemCount - 1) * spacing
    double totalSpacing = (itemCount - 1) * spacing;
    double itemWidth = (screenWidth - totalSpacing) / itemCount;

    return SizedBox(
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(itemCount, (index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              controller.pictures[index]['image'],
              width: itemWidth,
              height: 72,
              fit: BoxFit.cover,
            ),
          );
        }),
      ),
    );
  }
}
