// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:monitoring/API/api_constants.dart';
import 'package:monitoring/Models/model.dart';

class AuthService {
  Future<void> login() async {
    final url = Uri.parse('https://api-dev.allia.health/api/client/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': 'dev@alliauk.com',
        'password': '12345678',
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      accessToken = data['body']['accessToken'];
      print('Access Token: $accessToken');
    } else {
      print('Login failed: ${response.statusCode}');
    }
  }
}

class SelfReportService {
  Future<MoodResponse> getSelfReportQuestions() async {
    final url = Uri.parse(
        'https://api-dev.allia.health/api/client/self-report/question');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': accessToken ?? '',
    };

    final response = await http.get(url, headers: headers);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return MoodResponse.fromJson(data);
    } else {
      return MoodResponse.fromJson(data);
    }
  }
}
