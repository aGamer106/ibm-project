import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

class WatsonApi {
  Future<http.Response> textToSpeech(String text) async {
    var url = Uri.parse(dotenv.dotenv.env['TEXT_TO_SPEECH_URL']!);

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.dotenv.env['TEXT_TO_SPEECH_APIKEY']}',
      },
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load album');
    }
  }
}