import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pastor_lili/app.dart';
import 'package:pastor_lili/core/services/storage_service.dart';
import 'package:pastor_lili/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Stripe.publishableKey =
      'pk_test_51SJgge3fdpPCflwPTz4p8vzsliQ0xr0ve6b85cv72UMmjxhDfjcZGutxi5IsCekf36aXfEb4IPmAcio8N1JiBHsm00jbXWoOH8';
  configLoading();
  await StorageService.init();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    // ignore: deprecated_member_use
    ..backgroundColor = Colors.black.withOpacity(0.8)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    // ignore: deprecated_member_use
    ..maskColor = Colors.black.withOpacity(0.3)
    ..userInteractions = false
    ..dismissOnTap = false;
}
