import 'package:pokeval/models/card_prices.dart';

class PokemonCard {
  final String id;
  final String name;
  final String imageUrl;
  final String setName;
  final String rarity;
  final String? cardMarketUrl;
  final CardPrices? prices;

  PokemonCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.setName,
    required this.rarity,
    this.cardMarketUrl,
    this.prices,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'],
      name: json['name'],
      imageUrl: json['images']['large'],
      setName: json['set']['name'],
      rarity: json['rarity'],
      cardMarketUrl: json['cardmarket']?['url'],
      prices: json['cardmarket'] != null || json['tcgplayer'] != null
        ? CardPrices.fromJson(json)
        : null,
    );
  }
}