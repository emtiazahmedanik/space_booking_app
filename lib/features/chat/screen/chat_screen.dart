import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/chat/controller/chat_controller.dart';
import 'package:pastor_lili/features/chat/widget/build_message.dart';
import 'package:pastor_lili/features/chat/widget/message_input_field.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final ChatController controller = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                const CircleAvatar(radius: 24, child: Icon(Icons.person)),
                Positioned(
                  top: 2,
                  right: 3,
                  child: CircleAvatar(backgroundColor: Colors.green, radius: 5),
                ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Active Now", style: getTextStyle(fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                if (controller.conversations.isEmpty) {
                  return Center(child: Text("No messages yet"));
                }
                return ListView.builder(
                  itemCount: controller.conversations.length,
                  controller: controller.scrollController,
                  itemBuilder: (context, index) {
                    final msg = controller.conversations[index];
                    final isMe = msg["senderId"] == controller.userId.value;
                    return buildMessage(
                      isMe: isMe,
                      text: msg["content"],
                      time: controller.formatTime(msg["createdAt"]),
                      imageUrl: msg['imageUrl'],
                    );
                  },
                );
              }),
            ),
          ),
          MessageInputField(
            controller: messageController,
            onSend: () {
                controller.sendMessage(messageController.text.trim());
                messageController.clear();
                controller.selectedImagePath.value = "";
                controller.uploadedImageUrl.value = '';

            },
            onAddPressed: () async {
              await controller.pickImage();
            },
          ),
        ],
      ),
    );
  }
}
