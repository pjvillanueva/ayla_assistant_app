import 'package:flutter/material.dart';
import 'preferences_screen.dart';
import 'websocket_message_screen.dart';
import 'voice_activity_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.teal.shade50, Colors.teal.shade100],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Ayla',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your personal AI assistant',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.teal.shade600,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      _buildCard(
                        context,
                        'User Preferences',
                        'Manage user preferences',
                        Icons.settings,
                        Colors.blue,
                        const PreferencesScreen(),
                      ),
                      _buildCard(
                        context,
                        'WebSocket Messages',
                        'View messages in real-time',
                        Icons.message,
                        Colors.green,
                        const WebSocketMessageScreen(),
                      ),
                      _buildCard(
                        context,
                        'Voice Activity',
                        'Detect and display voice activity',
                        Icons.mic,
                        Colors.orange,
                        const VoiceActivityScreen(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String description,
      IconData icon, Color color, Widget? screen) {
    return SizedBox(
      height: 150,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: screen != null
              ? () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screen))
              : () {},
          child: Center(
            child: ListTile(
              leading: Icon(icon, size: 48, color: color),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              subtitle: Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
