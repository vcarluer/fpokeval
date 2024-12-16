```dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageUploader extends StatelessWidget {
  final Function(File) onImageSelect;
  final bool isLoading;

  const ImageUploader({
    super.key,
    required this.onImageSelect,
    required this.isLoading,
  });

  Future<void> _pickImage(BuildContext context) async {
    if (isLoading) return;

    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        onImageSelect(File(image.path));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la sélection de l\'image'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _pickImage(context),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Stack(
                children: [
                  Icon(
                    Icons.photo_camera,
                    size: 48,
                    color: Theme.of(context).primaryColor,
                  ),
                  const Positioned(
                    top: -4,
                    right: -4,
                    child: SparkleAnimation(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                isLoading
                    ? 'Analyse en cours...'
                    : 'Prenez une photo ou sélectionnez une image',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'ou cliquez pour sélectionner',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```