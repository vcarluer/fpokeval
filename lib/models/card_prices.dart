class CardPrices {
  final MarketPrices? cardmarket;
  final TcgPlayerPrices? tcgplayer;

  CardPrices({
    this.cardmarket,
    this.tcgplayer,
  });

  factory CardPrices.fromJson(Map<String, dynamic> json) {
    return CardPrices(
      cardmarket: json['cardmarket'] != null 
        ? MarketPrices.fromJson(json['cardmarket']) 
        : null,
      tcgplayer: json['tcgplayer'] != null 
        ? TcgPlayerPrices.fromJson(json['tcgplayer']) 
        : null,
    );
  }
}

class MarketPrices {
  final double? averageSellPrice;
  final double? lowPrice;
  final double? trendPrice;

  MarketPrices({
    this.averageSellPrice,
    this.lowPrice,
    this.trendPrice,
  });

  factory MarketPrices.fromJson(Map<String, dynamic> json) {
    return MarketPrices(
      averageSellPrice: json['prices']?['averageSellPrice']?.toDouble(),
      lowPrice: json['prices']?['lowPrice']?.toDouble(),
      trendPrice: json['prices']?['trendPrice']?.toDouble(),
    );
  }
}

class TcgPlayerPrices {
  final CardVariantPrices? holofoil;
  final CardVariantPrices? normal;

  TcgPlayerPrices({
    this.holofoil,
    this.normal,
  });

  factory TcgPlayerPrices.fromJson(Map<String, dynamic> json) {
    final prices = json['prices'] ?? {};
    return TcgPlayerPrices(
      holofoil: prices['holofoil'] != null 
        ? CardVariantPrices.fromJson(prices['holofoil']) 
        : null,
      normal: prices['normal'] != null 
        ? CardVariantPrices.fromJson(prices['normal']) 
        : null,
    );
  }
}

class CardVariantPrices {
  final double? market;
  final double? low;
  final double? high;

  CardVariantPrices({
    this.market,
    this.low,
    this.high,
  });

  factory CardVariantPrices.fromJson(Map<String, dynamic> json) {
    return CardVariantPrices(
      market: json['market']?.toDouble(),
      low: json['low']?.toDouble(),
      high: json['high']?.toDouble(),
    );
  }
}