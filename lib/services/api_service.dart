import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_preferences.dart';

class ApiService {
  final String baseUrl = 'https://my-json-server.typicode.com/AylaAI/mock-api';

  Future<UserPreferences> getUserPreferences(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    if (response.statusCode == 200) {
      return UserPreferences.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user preferences');
    }
  }

  Future<void> updateUserPreferences(int userId, UserPreferences preferences) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(preferences.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user preferences');
    }
  }
}