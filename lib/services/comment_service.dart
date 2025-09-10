import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tux_data_f/models/comment.dart';

class CommentService {
  static const String _baseUrl = 'http://localhost:8080/comments';
  final http.Client _client;

  CommentService(this._client);

  Future<List<Comment>> getCommentByDistributionId(int distributionId) async {
    final url = Uri.parse('$_baseUrl/distribution/$distributionId');
    try {
      final response = await _client.get(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
        final List<Comment> comments = body
            .map((dynamic item) =>
                Comment.fromJson(item as Map<String, dynamic>))
            .toList();

        return comments;
      } else {
        throw Exception(
            'Failed to load comments for this distribution. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
