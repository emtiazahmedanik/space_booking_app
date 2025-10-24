import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/utils/constants/colors.dart';
import 'package:pastor_lili/features/chat/controller/chat_controller.dart';
import 'package:shimmer/shimmer.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAddPressed;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              onPressed: onAddPressed,
              icon: Icon(Icons.add_circle_outline, color: Colors.grey),
            ),
            Obx(() {
              if (chatController.selectedImagePath.value.isEmpty) {
                return SizedBox.shrink();
              }
              return Stack(
                clipBehavior:
                    Clip.none, // ensures the cancel icon can go outside bounds
                children: [
                  // Image container
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      image: DecorationImage(
                        image: FileImage(
                          File(chatController.selectedImagePath.value),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Cancel icon (tappable)
                  Positioned(
                    top: -6,
                    right: -6,
                    child: GestureDetector(
                      onTap: () {
                        debugPrint("tapped on cancel");
                        chatController.selectedImagePath.value = '';
                      },
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black.withValues(alpha: .6),
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Type a message",
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => chatController.loading.value == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: onSend,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
