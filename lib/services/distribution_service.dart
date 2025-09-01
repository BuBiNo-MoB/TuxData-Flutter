import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tux_data_f/models/distribution.dart';

class DistributionService {
  static const String _baseUrl = 'http://localhost:8080/distributions';

  Future<List<Distribution>> getDistributions() async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
        final List<Distribution> distributions = body
            .map((dynamic item) =>
                Distribution.fromJson(item as Map<String, dynamic>))
            .toList();

        return distributions;
      } else {
        throw Exception(
            'Failed to load distributions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching distributions: $e');
    }
  }
}
