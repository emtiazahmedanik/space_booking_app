import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/bottom_navbar/controller/bottom_navbar_controller.dart';
import 'package:pastor_lili/features/chat/controller/chat_controller.dart';
import 'package:pastor_lili/routes/app_routes.dart';

class ChatListScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  final BottomNavController bottomNavController = Get.put(
    BottomNavController(),
  );

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Chat',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            onTap: () {
              //controller.scrollToBottom();
              Get.toNamed(AppRoute.chattingScreen);
              controller.scrollToBottom();

            },
            leading: Stack(
              children: [
                const CircleAvatar(radius: 24, child: Icon(Icons.person)),
                Positioned(
                  top: 2,
                  right: 3,
                  child: CircleAvatar(backgroundColor: Colors.green, radius: 5),
                ),
              ],
            ),
            title: Text(
              "Admin",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Obx(
              () => Text(
                controller.conversations.isNotEmpty
                    ? controller.conversations.last['content']
                    : "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.formatTime(DateTime.now().toString()),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
