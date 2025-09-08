import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tux_data_f/models/user.dart';

class UserService {
  static const String _baseUrl = 'http://localhost:8080/users';
  final http.Client _client;

  UserService(this._client);

  Future<List<User>> getAllUsers() async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await _client.get(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
        final List<User> users = body
            .map((dynamic item) => User.fromJson(item as Map<String, dynamic>))
            .toList();
        return users;
      } else {
        throw Exception(
            'Failed to load users : Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching users: $e');
    }
  }

  Future<User> getCurrentUser(String token) async {
    final url = Uri.parse('$_baseUrl/me');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // assuming JWT
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to fetch current user');
    }
  }
}

final userApiServiceProvider = Provider<UserService>((ref) {
  return UserService(http.Client());
});
