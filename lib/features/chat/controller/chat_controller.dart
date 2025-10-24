import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pastor_lili/core/services/end_points.dart';
import 'package:pastor_lili/core/services/space_service.dart';
import 'package:pastor_lili/core/services/storage_service.dart';
import 'package:pastor_lili/features/chat/service/chat_service.dart';
import 'package:pastor_lili/features/home/place_list/model/places_model.dart';

class ChatController extends GetxController {
  final ChatService _chatService = ChatService();

  final ScrollController scrollController = ScrollController();

  var conversations = [].obs;

  RxBool loading = false.obs;

  RxnString ownerId = RxnString();
  var userId = ''.obs;

  var selectedImagePath = ''.obs;
  var token = ''.obs;
  RxnString uploadedImageUrl = RxnString();

  // Image picker
  final ImagePicker _picker = ImagePicker();

  // 🔹 INITIALIZATION
  @override
  void onInit() {
    super.onInit();
    _initChat();
  }

  Future<void> _initChat() async {
    await _getReceiverSenderId();
    initSocket();
  }

  Future<void> initSocket() async {
    await _chatService.getToken();

    try {
      _chatService.connect();
      _chatService.on('conversation', (data) {
        conversations.value = data;
        debugPrint("The loaded conversations are: $data");
      });
      _chatService.on('receive_message', (data) {
        conversations.add(data);
        debugPrint("Received message: $data");
      });
      loadConversations();
    } catch (e) {
      debugPrint("The exception in socket is $e");
    }
  }

  void loadConversations() {
    Map<String, dynamic> data = {"userA": userId.value, "userB": ownerId.value};
    _chatService.emit('get_conversation', data);
  }

  // 🔹 STORAGE IDS
  Future<void> _getReceiverSenderId() async {
    if (ownerId.value == null) {
      final fetchedSpaces = await SpaceService.fetchSpaces();
      final SpaceModel spaceModel = fetchedSpaces.first;
      ownerId.value = spaceModel.ownerId;
    }
    userId.value = await StorageService.getUserId() ?? '';
    token.value = StorageService.token ?? '';
    if (kDebugMode) {
      print('Chat started → Owner: ${ownerId.value}, User: ${userId.value}');
    }
  }

  // 🔹 IMAGE PICKER
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
      debugPrint("image selected: ${selectedImagePath.value}");
      //uploadImageToCloud();
    }
  }
  //uploadImageToCLoud

  Future<void> uploadImageToCloud() async {
    if (selectedImagePath.value.isNotEmpty) {
      final url = Uri.parse('${Urls.baseUrl}/chat/upload-images');

      var request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
      request.files.add(
        await http.MultipartFile.fromPath('files', selectedImagePath.value),
      );

      try {
        final response = await request.send();
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);
        debugPrint("image uploaded response: $data");
        if (response.statusCode == 200 || response.statusCode == 201) {
          uploadedImageUrl.value = data['imageUrls'][0];
          debugPrint('uploadedUrls:$uploadedImageUrl');
        } else {
          if (kDebugMode) {
            print("error");
          }
        }
      } catch (e) {
        if (kDebugMode) print('Upload error: $e');
      }
    }
  }

  // 🔹 SEND MESSAGE
  void sendMessage(String content) async {
    if (userId.isEmpty) return;
    try {
      loading.value = true;
      if (selectedImagePath.value.isNotEmpty) {
        await uploadImageToCloud();
        debugPrint("image uploaded: $uploadedImageUrl");
      }
      _chatService.emit('sendMessage', {
        "senderId": userId.value,
        "receiverId": ownerId.value,
        "content": content,
        "imageUrl": uploadedImageUrl.value,
      });
      loading.value = false;
      uploadedImageUrl.value = '';
      scrollToBottom();
    } catch (e) {
      loading.value = false;
      debugPrint("Error:$e");
    }
  }

  //scroll to bottom
  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // 🔹 FORMAT TIME
  String formatTime(String createdAt) {
    final time = DateTime.tryParse(createdAt);
    if (time == null) return '';
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
  }
}
