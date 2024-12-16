```dart
import 'package:flutter/material.dart';
import 'package:pokeval/widgets/sparkle_animation.dart';

class RecognitionInfo extends StatelessWidget {
  final Map<String, dynamic> info;

  const RecognitionInfo({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Votre carte',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SparkleAnimation(),
              ],
            ),
            const SizedBox(height: 16),
            if (info['name'] != null)
              InfoRow(label: 'Nom :', value: info['name']),
            if (info['englishName'] != null)
              InfoRow(label: 'Nom anglais :', value: info['englishName']),
            if (info['subtype'] != null)
              InfoRow(label: 'Type :', value: info['subtype']),
            if (info['hp'] != null)
              InfoRow(label: 'Points de vie :', value: info['hp']),
            const SizedBox(height: 16),
            Text(
              info['cardFound'] == true
                  ? 'Carte identifiée avec succès !'
                  : 'Recherche de correspondances en cours...',
              style: const TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
```