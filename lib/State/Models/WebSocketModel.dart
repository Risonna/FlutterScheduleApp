import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/State/Models/AdminsTeachersModel.dart';
import 'package:flutter_test_scheduler/blogic/requests/globalUrl.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketModel with ChangeNotifier {
  WebSocketChannel? _channel;
  late StreamSubscription<dynamic> _streamSubscription;

  WebSocketChannel? get channel => _channel;

  void connect(BuildContext context) {
    _channel = WebSocketChannel.connect(Uri.parse('ws://${globalUrl}websocket/entity'));
    _streamSubscription = _channel!.stream.listen(
          (message) {
        handleMessage(message, context);
      },
      onDone: () {
        // Handle WebSocket close
        print('WebSocket closed');
      },
      onError: (error) {
        // Handle WebSocket errors
        print('WebSocket error: $error');
      },
    );
    notifyListeners();
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    _streamSubscription.cancel(); // Cancel the stream subscription when disposing
    notifyListeners();
  }

  void handleMessage(dynamic message, BuildContext context) {
    // Handle incoming messages
    if (message.toString() == 'refetchAdminsTeachers') {
      print('message received, the message is ' + message.toString().toLowerCase());
      Provider.of<AdminsTeachersModel>(context, listen: false).fetchAdminsTeachers();
    }
    // Add more logic as needed
  }
}
