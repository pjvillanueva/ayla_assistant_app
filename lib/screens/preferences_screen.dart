// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:ayla_assistant_app/widgets/preference_display.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final ApiService _apiService = ApiService();
  UserPreferences? _userPreferences;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final prefs = await _apiService.getUserPreferences(1);
      setState(() {
        _userPreferences = prefs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load preferences: $e')),
      );
    }
  }

  Future<void> _savePreferences(UserPreferences updatedPreferences) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _apiService.updateUserPreferences(
          updatedPreferences.id, updatedPreferences);
      setState(() {
        _userPreferences = updatedPreferences;
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferences saved successfully')),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save preferences: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Preferences'),
        backgroundColor: Colors.teal.shade600,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade50, Colors.teal.shade100],
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _userPreferences == null
                ? Center(
                    child: Text(
                    'Failed to load preferences',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: PreferencesDisplay(
                      userPreferences: _userPreferences!,
                      onSave: _savePreferences,
                    ),
                  ),
      ),
    );
  }
}
