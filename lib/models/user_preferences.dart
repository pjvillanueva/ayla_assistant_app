class UserPreferences {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;
  Preferences preferences;

  UserPreferences({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.preferences,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      preferences: Preferences.fromJson(json['preferences']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'preferences': preferences.toJson(),
    };
  }
}

class Preferences {
  bool preference1;
  List<String> preference2;
  String preference3;

  Preferences({
    required this.preference1,
    required this.preference2,
    required this.preference3,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      preference1: json['preference1'],
      preference2: List<String>.from(json['preference2']),
      preference3: json['preference3'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preference1': preference1,
      'preference2': preference2,
      'preference3': preference3,
    };
  }
}
