import 'package:get/get.dart';
import 'package:pastor_lili/features/auth/forget_password/view/forget_password_view.dart';
import 'package:pastor_lili/features/auth/login/view/login_view.dart';
import 'package:pastor_lili/features/auth/signup/view/sign_up_view.dart';
import 'package:pastor_lili/features/bottom_navbar/view/bottom_navbar_view.dart';
import 'package:pastor_lili/features/chat/screen/chat_list_screen.dart';
import 'package:pastor_lili/features/chat/screen/chat_screen.dart';
import 'package:pastor_lili/features/home/place_details/view/place_details_view.dart';
import 'package:pastor_lili/features/splash/screens/splash_screen.dart';

class AppRoute {
  // Main App Routes
  static String splashScreen = '/splashScreen';

  static String loginScreen = '/loginScreen';

  static String signupScreen = '/signupScreen';
  static String chatListScreen = '/chatListScreen';
  static String chattingScreen = '/chattingScreen';
  static String forgetPasswordScreen = '/forgetPasswordScreen';
  static String bottomNavbarView = '/bottomNavbarView';
  static String placeDetailsScreen = '/placeDetailsScreen';

  // Route Getters
  static String getSplashScreen() => splashScreen;
  static String getLoginScreen() => loginScreen;
  static String getSignupScreen() => signupScreen;
  static String getForgetPasswordScreen() => forgetPasswordScreen;
  static String getBottomNavbarView() => bottomNavbarView;
  static String getPlaceDetailsView() => placeDetailsScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginView()),
    GetPage(name: signupScreen, page: () => SignUpView()),
    GetPage(name: forgetPasswordScreen, page: () => ForgetPasswordView()),
    GetPage(name: bottomNavbarView, page: () => BottomNavbarView()),
    GetPage(name: placeDetailsScreen, page: () => PlaceDetailsView()),
    GetPage(name: chatListScreen, page: () => ChatListScreen()),
    GetPage(name: chattingScreen, page: () => ChatScreen()),
  ];
}
