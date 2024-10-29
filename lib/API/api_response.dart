// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:monitoring/API/api_constants.dart';

Future<void> sendFirstResponse(
    String selectedQuestionId, String selectedOptionId) async {
  int questionId = int.tryParse(selectedQuestionId) ?? -1;
  int optionId = int.tryParse(selectedOptionId) ?? -1;

  final response = await http.post(
    Uri.parse('https://api-dev.allia.health/api/client/self-report/answer'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': accessToken ?? '',
    },
    body: jsonEncode({
      'answers': [
        {
          'questionId': questionId,
          'selectedOptionId': optionId,
          'freeformValue': null,
        }
      ],
    }),
  );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Response sent successfully');
  } else {
    print('Failed to send first response: ${response.statusCode}');
  }
}

Future<void> sendSecondResponse(double sliderValue) async {
  int id = 498 + (sliderValue / 10).round();

  final response = await http.post(
    Uri.parse('https://api-dev.allia.health/api/client/self-report/answer'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': accessToken ?? '',
    },
    body: jsonEncode({
      'answers': [
        {
          'questionId': 119,
          'selectedOptionId': id,
          'freeformValue': null,
        }
      ],
    }),
  );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Response sent successfully');
  } else {
    print('Failed to send response: ${response.statusCode}');
  }
}
