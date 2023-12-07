import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketModel with ChangeNotifier {
  WebSocketChannel? _channel;

  WebSocketChannel? get channel => _channel;

  void connect(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    notifyListeners();
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    notifyListeners();
  }

// Add methods for sending/receiving messages, error handling, etc.
}
