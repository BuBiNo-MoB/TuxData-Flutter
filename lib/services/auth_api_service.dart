import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';

class AuthApiService {
  final String _baseUrl = 'http://localhost:8080';
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

  Future<void> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    File? avatar,
  }) async {
    final url = Uri.parse('$_baseUrl/users');

    try {
      var request = http.MultipartRequest('POST', url);

      request.headers['Content-Type'] = 'multipart/form-data';

      final userJson = jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
        'password': password,
      });

      request.files.add(
        http.MultipartFile.fromString(
          'user',
          userJson,
          contentType: MediaType('application', 'json'),
        ),
      );

      if (avatar != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'avatar',
            avatar.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        String errorMessage = 'Registrazione fallita: ${response.statusCode}';
        if (response.body.isNotEmpty) {
          try {
            final errorBody = jsonDecode(response.body);
            errorMessage = errorBody['message'] ?? errorMessage;
          } catch (e) {
            errorMessage += ' - ${response.body}';
          }
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Errore di rete o del server: $e');
    }
  }
}

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  return AuthApiService(http.Client());
});
