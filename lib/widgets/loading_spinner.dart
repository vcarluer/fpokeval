```dart
import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final String message;
  final String? subMessage;

  const LoadingSpinner({
    super.key,
    required this.message,
    this.subMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (subMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            subMessage!,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ],
    );
  }
}
```