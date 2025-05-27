// lib/widgets/tip_card.dart
import 'package:flutter/material.dart';

/// Widget que muestra una tarjeta con un consejo o tip.
///
/// Recibe un título, descripción y la ruta de la imagen asociada.
class TipCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const TipCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          // Aquí podrías implementar la lógica para ver detalles del tip.
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Asegúrate de tener la imagen en la carpeta assets y declarada en pubspec.yaml.
              Image.asset(imagePath, height: 100, fit: BoxFit.cover),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(description, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
