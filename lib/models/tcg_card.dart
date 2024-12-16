class TcgCard {
  final String id;
  final String name;
  final String rarity;
  final CardImages images;
  final CardSet set;

  TcgCard({
    required this.id,
    required this.name,
    required this.rarity,
    required this.images,
    required this.set,
  });

  factory TcgCard.fromJson(Map<String, dynamic> json) {
    return TcgCard(
      id: json['id'],
      name: json['name'],
      rarity: json['rarity'],
      images: CardImages.fromJson(json['images']),
      set: CardSet.fromJson(json['set']),
    );
  }
}

class CardImages {
  final String small;
  final String large;

  CardImages({
    required this.small,
    required this.large,
  });

  factory CardImages.fromJson(Map<String, dynamic> json) {
    return CardImages(
      small: json['small'],
      large: json['large'],
    );
  }
}

class CardSet {
  final String name;
  final String series;

  CardSet({
    required this.name,
    required this.series,
  });

  factory CardSet.fromJson(Map<String, dynamic> json) {
    return CardSet(
      name: json['name'],
      series: json['series'],
    );
  }
}