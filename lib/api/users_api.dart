import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:futurebuilder_example/model/user.dart';

class UsersApi {
  // Load JSON bundled with the Flutter application.
  static Future<List<User>> getUsersLocally() async {
    final String data = await rootBundle.loadString(
      'assets/users.json',
    );

    return _parseUsers(data);
  }

  // Load JSON from a remote server.
  static Future<List<User>> getUsers() async {
    final uri = Uri.parse(
      'assets/users.json',
    );

    final response = await http.get(uri).timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load users. HTTP status: ${response.statusCode}',
      );
    }

    return _parseUsers(response.body);
  }

  // Convert JSON text into a list of User objects.
  static List<User> _parseUsers(String data) {
    final dynamic decoded = jsonDecode(data);

    if (decoded is! List) {
      throw const FormatException(
        'Invalid JSON format. Expected a list of users.',
      );
    }

    return decoded.map<User>((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException(
          'Invalid user object in JSON data.',
        );
      }

      return User.fromJson(item);
    }).toList();
  }
}
