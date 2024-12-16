import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokeval/config/api_config.dart';
import 'package:pokeval/models/tcg_card.dart';
import 'package:pokeval/utils/logger.dart';

class TcgApi {
  static final _client = http.Client();
  static const _baseUrl = 'https://api.pokemontcg.io/v2';

  static Future<List<TcgCard>> searchByNameAndType(String query) async {
    try {
      Logger.info('Recherche TCG:', {'query': query});

      final response = await _client.get(
        Uri.parse('$_baseUrl/cards?q=$query&orderBy=-set.releaseDate&pageSize=10'),
        headers: {'X-Api-Key': ApiConfig.tcgApiKey},
      );

      if (response.statusCode != 200) {
        throw Exception('Erreur API TCG: ${response.statusCode}');
      }

      final data = json.decode(response.body);
      final cards = (data['data'] as List)
        .map((card) => TcgCard.fromJson(card))
        .toList();

      Logger.info('Résultat recherche TCG:', {
        'query': query,
        'cardsFound': cards.length,
      });

      return cards;
    } catch (e) {
      Logger.error('Erreur recherche TCG:', {
        'query': query,
        'error': e.toString(),
      });
      throw Exception('Erreur lors de la recherche TCG');
    }
  }
}