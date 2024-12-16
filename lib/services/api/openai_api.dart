import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokeval/config/api_config.dart';
import 'package:pokeval/utils/logger.dart';
import 'package:pokeval/utils/image_utils.dart';

class OpenAiApi {
  static final _client = http.Client();
  static const _baseUrl = 'https://api.openai.com/v1';

  static Future<Map<String, dynamic>> analyzeCard(String imagePath) async {
    try {
      final base64Image = await ImageUtils.fileToBase64(imagePath);
      
      final response = await _client.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${ApiConfig.openaiApiKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'model': 'gpt-4-vision-preview',
          'messages': [
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text': ApiConfig.analysisPrompt,
                },
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:image/jpeg;base64,$base64Image'
                  }
                }
              ]
            }
          ],
          'max_tokens': 150,
          'temperature': 0.1,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Erreur API OpenAI: ${response.statusCode}');
      }

      final data = json.decode(response.body);
      final content = data['choices'][0]['message']['content'];
      
      Logger.info('Réponse OpenAI:', content);

      return json.decode(content);
    } catch (e) {
      Logger.error('Erreur analyse OpenAI:', e);
      throw Exception('Erreur lors de l\'analyse de la carte');
    }
  }
}