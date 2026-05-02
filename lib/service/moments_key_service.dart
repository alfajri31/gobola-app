import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/config.dart';

class MomentsKeyService {

  Future<Map<String, dynamic>> fetchMomentsKeyApi(int page, int size) async {
    final url = Uri.parse('${AppConfig.baseUrl}/match/key_moments');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(url, headers: headers);
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
