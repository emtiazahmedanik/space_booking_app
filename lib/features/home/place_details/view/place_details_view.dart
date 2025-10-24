import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/home/bookings/view/bookings_screen.dart'
    show BookingsScreen;
import 'package:pastor_lili/features/home/place_details/components/details_button.dart';
import 'package:pastor_lili/features/home/place_details/controller/place_details_controller.dart';
import 'package:pastor_lili/features/home/place_details/widgets/amenities_and_features.dart'
    show AmenitiesAndFeatures;
import 'package:pastor_lili/features/home/place_details/widgets/guidelines_and_rules.dart'
    show GuidelinesAndRules;
import 'package:pastor_lili/features/home/place_details/widgets/images_list.dart'
    show ImagesList;
import 'package:pastor_lili/features/home/place_details/widgets/place_description.dart'
    show PlaceDescription;
import 'package:pastor_lili/features/home/place_details/widgets/place_title.dart'
    show PlaceTitle;
import 'package:pastor_lili/features/home/place_details/widgets/review_and_ratings.dart'
    show ReviewAndRatings;
import 'package:pastor_lili/features/home/place_list/model/places_model.dart';
import 'package:pastor_lili/routes/app_routes.dart';

class PlaceDetailsView extends StatelessWidget {
  PlaceDetailsView({super.key});

  final PlaceDetailsController controller = Get.put(PlaceDetailsController());

  final RxInt _currentIndex = 0.obs;

  final SpaceModel spaceModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "Details",
          style: getTextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CarouselSlider.builder(
                        itemCount: controller.pictures.length,
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  controller.pictures[index]['image'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 200,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            _currentIndex.value = index;
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.pictures.asMap().entries.map((
                          entry,
                        ) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex.value == entry.key
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              ImagesList(),
              SizedBox(height: 24),
              PlaceTitle(spaceModel: spaceModel),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Price: \$${spaceModel.price}/hr",
                  style: getTextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailsButton(
                    text: "Message",
                    onPressed: () {
                      Get.toNamed(AppRoute.chatListScreen);
                    },
                    color: Color(0xFFF0E9F1),
                    textColor: AppColors.primaryColor,
                  ),
                  DetailsButton(
                    text: "Book Now",
                    onPressed: () {
                      Get.to(BookingsScreen(), arguments: spaceModel);
                    },
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 20),
              PlaceDescription(spaceModel: spaceModel),
              SizedBox(height: 24),
              AmenitiesAndFeatures(spaceModel: spaceModel),
              SizedBox(height: 30),

              GuidelinesAndRules(spaceModel: spaceModel),
              SizedBox(height: 30),
              ReviewAndRatings(),
            ],
          ),
        ),
      ),
    );
  }
}
