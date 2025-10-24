// ignore_for_file: library_prefixes
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pastor_lili/core/services/end_points.dart';
import 'package:pastor_lili/core/services/storage_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  IO.Socket? socket;

  var token = ''.obs;

  Future<void> getToken() async {
    String accessToken = StorageService.token ?? '';
    token.value = 'Bearer $accessToken';
    if (kDebugMode) {
      print("The token is ${token.value}");
    }
  }

  final String baseUrl = "${Urls.baseUrl}/chat";

  void connect() {
    socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .setExtraHeaders({'Authorization': token.value})
          .build(),
    );

    socket?.onConnect((_) => debugPrint("✅ Connected to socket server"));

    socket?.onDisconnect(
      (_) => debugPrint("❌ Disconnected from socket server"),
    );
  }

  void emit(String event, dynamic data, {Function(dynamic)? ack}) {
    if (ack != null) {
      socket?.emitWithAck(event, data, ack: ack);
    } else {
      socket?.emit(event, data);
    }
  }

  void on(String event, Function(dynamic) callback) {
    socket?.on(event, callback);
  }

  void dispose() {
    socket?.dispose();
  }
}
