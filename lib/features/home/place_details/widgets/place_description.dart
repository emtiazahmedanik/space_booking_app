import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/features/home/place_details/controller/place_details_controller.dart';

import '../../place_list/model/places_model.dart';

class PlaceDescription extends StatelessWidget {
  PlaceDescription({super.key, required this.spaceModel});

  final PlaceDetailsController controller = Get.find<PlaceDetailsController>();
  final SpaceModel spaceModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Description",
            style: getTextStyle(
              color: Color(0xFF444444),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          spaceModel.description,
          textAlign: TextAlign.justify,
          style: getTextStyle(
            color: Color(0xFF7D7D7D),
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
