import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class SocketService {
  late WebSocketChannel _channel;
  final StreamController<Map<String, dynamic>> _socketStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  // Getter for the UI to listen to
  Stream<Map<String, dynamic>> get cartStream => _socketStreamController.stream;

  // Replace with your actual FastAPI local/server IP
  final String _baseUrl = 'ws://10.0.2.2:8000/ws';

  void connect(String sessionId) {
    try {
      // Connecting to the backend with a specific session/group ID
      _channel = WebSocketChannel.connect(Uri.parse('$_baseUrl/$sessionId'));

      _channel.stream.listen(
        (message) {
          final data = jsonDecode(message);
          _socketStreamController.add(data);
          print("New Sync-Cart Data: $data");
        },
        onError: (error) {
          print("WebSocket Error: $error");
          _reconnect(sessionId);
        },
        onDone: () {
          print("WebSocket Connection Closed");
        },
      );
    } catch (e) {
      print("Connection Exception: $e");
    }
  }

  // Send a new scanned item to the shared basket
  void sendItem(Map<String, dynamic> itemData) {
    _channel.sink.add(jsonEncode(itemData));
  }

  void _reconnect(String sessionId) {
    Future.delayed(Duration(seconds: 5), () => connect(sessionId));
  }

  void dispose() {
    _channel.sink.close(status.goingAway);
    _socketStreamController.close();
  }
}
