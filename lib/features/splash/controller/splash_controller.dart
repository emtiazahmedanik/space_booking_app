import 'package:get/get.dart';
import 'package:pastor_lili/features/onboarding/onboarding_screen1.dart';
import 'package:pastor_lili/core/services/storage_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () async {
      await StorageService.init();

      if (StorageService.hasToken()) {
        Get.offAllNamed('/bottomNavbarView');
      } else {
        Get.offAll(OnboardingScreen1());
      }
    });
  }
}
