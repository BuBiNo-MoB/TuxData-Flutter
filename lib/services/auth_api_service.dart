import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthApiService {
  final String _baseUrl =
      'http://localhost:8080'; //10.0.2.2 per emulatore android
  final http.Client _client;

  AuthApiService(this._client);

  Future<String> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/users/login');
    try {
      final response = await _client.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final token = body['token'];
        if (token != null) {
          return token;
        } else {
          throw Exception('Token non trovato nella risposta');
        }
      } else {
        throw Exception('Login fallito: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errore di rete o del server: $e');
    }
  }
}

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  return AuthApiService(http.Client());
});
