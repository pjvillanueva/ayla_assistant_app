// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceActivityDetector extends StatefulWidget {
  final Function(String detectedText) onSpeechDetected;

  const VoiceActivityDetector({
    super.key,
    required this.onSpeechDetected,
  });

  @override
  _VoiceActivityDetectorState createState() => _VoiceActivityDetectorState();
}

class _VoiceActivityDetectorState extends State<VoiceActivityDetector> {
  stt.SpeechToText? _speech;
  bool _isSpeechInitialized = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _startListening();
  }

  Future<void> requestPermissions() async {
    await Permission.microphone.request();
  }

  void _startListening() async {
    if (!await Permission.microphone.isGranted) {
      await Permission.microphone.request();
    }

    if (!_isSpeechInitialized) {
      bool available = await _speech!.initialize();
      if (available) {
        _isSpeechInitialized = true;
        _speech!.listen(
          onResult: (result) {
            if (result.hasConfidenceRating && result.confidence > 0.5) {
              widget.onSpeechDetected(result.recognizedWords);
              _stopListening();
              // Restart listening after processing the result
              Future.delayed(const Duration(seconds: 1), _startListening);
            }
          },
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 5),
          listenOptions: stt.SpeechListenOptions(partialResults: true),
        );
      }
    }
  }

  void _stopListening() async {
    if (_isSpeechInitialized) {
      _speech!.stop();
      _isSpeechInitialized = false;
    }
  }

  @override
  void dispose() {
    if (_isSpeechInitialized) {
      _stopListening();
    }
    _speech?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.teal.shade600,
      ),
      child: const Center(
        child: Icon(Icons.hearing, size: 100, color: Colors.white),
      ),
    );
  }
}
