import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/config.dart';

class MatchService {

  Future<Map<String, dynamic>> fetchMatchDataApi(int page, int size) async {
    final url = Uri.parse('${AppConfig.baseUrl}/match');
    final body = json.encode({
      'startDate': '2025-01-01',
      'endDate': '2025-01-31',
      'page': page,
      'size': size,
    });
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        return json.decode(response.body);  // Return decoded response when successful
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');  // Throw error if status code is not 200
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchLiveCountDataApi() async {
    final url = Uri.parse('${AppConfig.baseUrl}/match/live/count');
    final body = json.encode({});
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        return json.decode(response.body);  // Return decoded response when successful
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');  // Throw error if status code is not 200
      }
    } catch (e) {
      rethrow;
    }
  }

}
