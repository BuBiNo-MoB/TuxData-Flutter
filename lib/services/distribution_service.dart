import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tux_data_f/models/distribution.dart';

class DistributionService {
  static const String _baseUrl = 'http://localhost:8080/distributions';
  final http.Client _client;

  DistributionService(this._client);

  Future<List<Distribution>> getAllDistributions() async {
    final url = Uri.parse(_baseUrl);
    try {
      final response = await _client.get(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

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

  Future<Distribution> getDistribution(int id) async {
    final url = Uri.parse('$_baseUrl/$id');
    try {
      final response = await _client.get(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body =
            jsonDecode(utf8.decode(response.bodyBytes));
        return Distribution.fromJson(body);
      } else {
        throw Exception(
            'Failed to load distribution. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network or server error: $e');
    }
  }

  Future<List<Distribution>> searchDistributions(String keyword) async {
    final url = Uri.parse('$_baseUrl/search?keyword=$keyword');

    try {
      final response = await _client.get(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
        final List<Distribution> distributions = body
            .map((dynamic item) =>
                Distribution.fromJson(item as Map<String, dynamic>))
            .toList();

        return distributions;
      } else {
        throw Exception(
            'Failed to search distributions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network or server error: $e');
    }
  }

  Future<List<Distribution>> getDistributionsByDesktopEnvironment(
      String desktopEnvironment) async {
    final url = Uri.parse(
        '$_baseUrl/searchByDesktopEnvironment?desktopEnvironment=$desktopEnvironment');

    try {
      final response = await _client.get(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
        final List<Distribution> distributions = body
            .map((dynamic item) =>
                Distribution.fromJson(item as Map<String, dynamic>))
            .toList();

        return distributions;
      } else {
        throw Exception(
            'Failed to search distributions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network or server error: $e');
    }
  }
}

final distributionApiServiceProvider = Provider<DistributionService>((ref) {
  return DistributionService(http.Client());
});
