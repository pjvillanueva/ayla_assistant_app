// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../models/user_preferences.dart';

class PreferencesDisplay extends StatefulWidget {
  final UserPreferences userPreferences;
  final Function(UserPreferences) onSave;

  const PreferencesDisplay({
    super.key,
    required this.userPreferences,
    required this.onSave,
  });

  @override
  _PreferencesDisplayState createState() => _PreferencesDisplayState();
}

class _PreferencesDisplayState extends State<PreferencesDisplay> {
  late UserPreferences _editedPreferences;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _editedPreferences = UserPreferences(
      id: widget.userPreferences.id,
      name: widget.userPreferences.name,
      username: widget.userPreferences.username,
      email: widget.userPreferences.email,
      phone: widget.userPreferences.phone,
      website: widget.userPreferences.website,
      preferences: Preferences(
        preference1: widget.userPreferences.preferences.preference1,
        preference2: List.from(widget.userPreferences.preferences.preference2),
        preference3: widget.userPreferences.preferences.preference3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('User Information'),
              _buildInfoRow('Name', _editedPreferences.name),
              _buildInfoRow('Username', _editedPreferences.username),
              _buildInfoRow('Email', _editedPreferences.email),
              _buildInfoRow('Phone', _editedPreferences.phone),
              _buildInfoRow('Website', _editedPreferences.website),
              const SizedBox(height: 16),
              _buildSectionTitle('Preferences'),
              _buildPreference1Row(),
              _buildPreference2Row(),
              _buildPreference3Row(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white),
                onPressed: _savePreferences,
                child: const Text('Save Preferences'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildPreference1Row() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const SizedBox(
            width: 100,
            child: Text(
              'Preference 1',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Switch(
            value: _editedPreferences.preferences.preference1,
            activeColor: Colors.teal.shade600,
            inactiveTrackColor: Colors.white,
            onChanged: (bool value) {
              setState(() {
                _editedPreferences.preferences.preference1 = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreference2Row() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 100,
            child: Text(
              'Preference 2',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: TextFormField(
              initialValue:
                  _editedPreferences.preferences.preference2.join(', '),
              onSaved: (value) {
                _editedPreferences.preferences.preference2 =
                    value?.split(',').map((e) => e.trim()).toList() ?? [];
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter at least one value';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter comma-separated values',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreference3Row() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 100,
            child: Text(
              'Preference 3',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: TextFormField(
              initialValue: _editedPreferences.preferences.preference3,
              onSaved: (value) {
                _editedPreferences.preferences.preference3 = value ?? '';
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _savePreferences() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSave(_editedPreferences);
    }
  }
}
