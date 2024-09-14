// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../widgets/voice_activity_detector.dart';

class VoiceActivityScreen extends StatefulWidget {
  const VoiceActivityScreen({super.key});
  @override
  _VoiceActivityScreenState createState() => _VoiceActivityScreenState();
}

class _VoiceActivityScreenState extends State<VoiceActivityScreen> {
  String _detectionStatus = 'Speak something';

  void _onSpeechDetected(String detectedText) {
    setState(() {
      _detectionStatus = detectedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(title: const Text('Voice Activity Detector')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _detectionStatus,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            VoiceActivityDetector(
              onSpeechDetected: _onSpeechDetected,
            ),
          ],
        ),
      ),
    );
  }
}
