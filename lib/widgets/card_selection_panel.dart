```dart
import 'package:flutter/material.dart';
import 'package:pokeval/models/tcg_card.dart';
import 'package:pokeval/widgets/sparkle_animation.dart';

class CardSelectionPanel extends StatelessWidget {
  final List<TcgCard> cards;
  final Function(TcgCard) onSelect;
  final VoidCallback onBack;
  final File currentFile;
  final Map<String, dynamic>? recognizedInfo;
  final String? searchMethod;

  const CardSelectionPanel({
    super.key,
    required this.cards,
    required this.onSelect,
    required this.onBack,
    required this.currentFile,
    this.recognizedInfo,
    this.searchMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Sélectionnez votre carte',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Plusieurs cartes correspondent à votre recherche',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (searchMethod != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Recherche avec la stratégie : $searchMethod',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return CardSelectionItem(
                  card: card,
                  isFirst: index == 0,
                  onSelect: () => onSelect(card),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onBack,
              child: const Text('Recommencer'),
            ),
          ],
        ),
      ),
    );
  }
}

class CardSelectionItem extends StatelessWidget {
  final TcgCard card;
  final bool isFirst;
  final VoidCallback onSelect;

  const CardSelectionItem({
    super.key,
    required this.card,
    required this.isFirst,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isFirst ? Colors.yellow[50] : null,
      child: InkWell(
        onTap: onSelect,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Image.network(
                card.images.small,
                width: 80,
                height: 112,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${card.set.series} - ${card.set.name}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Rareté: ${card.rarity}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (isFirst) const SparkleAnimation(),
            ],
          ),
        ),
      ),
    );
  }
}
```