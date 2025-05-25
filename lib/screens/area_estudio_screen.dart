// lib/screens/area_estudio_screen.dart
import 'package:flutter/material.dart';
import '../widgets/tip_card.dart';

/// Pantalla del Área de Estudio.
///
/// Muestra una lista de consejos para mejorar las habilidades de captación.
class AreaEstudioScreen extends StatelessWidget {
  const AreaEstudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de ejemplos de tips.
    final List<Map<String, String>> tips = [
      {
        'title': 'Consejo 1',
        'description': 'Mejora tu comunicación con el cliente.',
        'image': 'assets/images/tip1.png',
      },
      {
        'title': 'Consejo 2',
        'description': 'Aprende a escuchar las necesidades.',
        'image': 'assets/images/tip2.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Área de Estudio')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TipCard(
              title: tip['title']!,
              description: tip['description']!,
              imagePath: tip['image']!,
            ),
          );
        },
      ),
    );
  }
}
