import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/utils/constants/icon_path.dart';
import 'package:pastor_lili/features/bottom_navbar/controller/bottom_navbar_controller.dart'
    show BottomNavController;
import 'package:pastor_lili/features/calender/view/calender_view.dart'
    show CalenderView;
import 'package:pastor_lili/features/chat/screen/chat_list_screen.dart';
import 'package:pastor_lili/features/home/place_list/view/place_list_view.dart'
    show PlaceListView;

import '../../profile/my_profile/view/profile_page.dart';

class BottomNavbarView extends StatelessWidget {
  BottomNavbarView({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> screens = [
    PlaceListView(),
    CalenderView(),
    ChatListScreen(),
    ProfilePage(),
  ];

  final List<String> activeIcons = [
    IconPath.activeHome,
    IconPath.activeCalender,
    IconPath.activeChat,
    IconPath.activeProfile,
  ];

  final List<String> inactiveIcons = [
    IconPath.inactiveHome,
    IconPath.inactiveCalender,
    IconPath.inactiveChat,
    IconPath.inactiveProfile,
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0x00000008),
                blurRadius: 7,
                offset: const Offset(0, 0),
              ),
              BoxShadow(
                color: const Color(0x1A000000),
                blurRadius: 4,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: List.generate(4, (index) {
              final isActive = controller.currentIndex.value == index;
              return BottomNavigationBarItem(
                icon: Image.asset(
                  isActive ? activeIcons[index] : inactiveIcons[index],
                  width: 32,
                  height: 32,
                ),
                label: '',
              );
            }),
          ),
        ),
      );
    });
  }
}
