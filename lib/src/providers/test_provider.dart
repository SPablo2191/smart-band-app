// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vital/src/core/consts/api_route_map.dart';
import 'package:vital/src/models/test_model.dart';

class TestProvider {
  final String _url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String route = getApiRoutes()['tests'] ?? '';

  Future<bool> createTest(Test newTest, String? accessToken) async {
    try {
      final url = Uri.parse('$_url$route/${newTest.teacher_id}');
      String body = jsonEncode(newTest.getMap());
      print(body);
      final resp = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: body,
      );

      if (resp.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<Test>> getTests(String? accessToken) async {
    try {
      final url = Uri.parse('$_url$route');
      final resp = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      final decodedData = json.decode(resp.body);
      final tests = Tests.fromJsonList(decodedData);
      return tests.items;
    } catch (e) {
      return [];
    }
  }
}