import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/utils/constants/image_path.dart';
import 'package:pastor_lili/features/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    final String logo = ImagePath.logo;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(logo, width: screenWidth * .4)),
    );
  }
}
