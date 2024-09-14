// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../services/websocket_service.dart';

class WebSocketMessageScreen extends StatefulWidget {
  const WebSocketMessageScreen({super.key});

  @override
  _WebSocketMessageScreenState createState() => _WebSocketMessageScreenState();
}

class _WebSocketMessageScreenState extends State<WebSocketMessageScreen> {
  final WebSocketService _webSocketService = WebSocketService();
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _webSocketService.connect();
    _webSocketService.messages.listen((message) {
      setState(() {
        _messages.add('Received: $message');
      });
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _webSocketService.sendMessage(_messageController.text);
      setState(() {
        _messages.add('Sent: ${_messageController.text}');
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Messages'),
        backgroundColor: Colors.teal.shade600,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade50, Colors.teal.shade100],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  var isSent = _messages[index].contains('Sent');
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    color: isSent ? Colors.teal : Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),

                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      title: Text(
                        _messages[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: isSent ? Colors.white : Colors.teal.shade800,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.teal.shade50,
                      ),
                      style: TextStyle(
                        color: Colors.teal.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Send',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
