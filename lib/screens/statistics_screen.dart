// lib/screens/statistics_screen.dart
import 'package:flutter/material.dart';

/// Modelo simple para tus objetos de inventario (aquí medallas).
class InventoryItem {
  final String name;
  final String assetPath;
  final int quantity;
  const InventoryItem({
    required this.name,
    required this.assetPath,
    this.quantity = 1,
  });
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  // Ejemplo de datos; reemplaza con tu lógica real.
  List<InventoryItem> get _items => const [
    InventoryItem(
      name: 'Medalla Primer Día',
      assetPath: 'assets/medals/medal1.png',
      quantity: 1,
    ),
    InventoryItem(
      name: 'Medalla 10 Preguntas',
      assetPath: 'assets/medals/medal2.png',
      quantity: 1,
    ),
    InventoryItem(
      name: 'Bonus Semanal',
      assetPath: 'assets/medals/bonus.png',
      quantity: 2,
    ),
    // …más items…
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF15082F),
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final isWide = constraints.maxWidth > 600;
          final crossCount = isWide ? 4 : 2;
          final spacing = 16.0;

          if (_items.isEmpty) {
            return const Center(
              child: Text(
                'Aún no tienes medallas',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            );
          }

          return GridView.builder(
            itemCount: _items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (_, i) {
              final item = _items[i];
              return _InventoryCard(item: item);
            },
          );
        },
      ),
    );
  }
}

class _InventoryCard extends StatelessWidget {
  final InventoryItem item;
  const _InventoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2C2655), Color(0xFF15082F)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Expanded(child: Image.asset(item.assetPath, fit: BoxFit.contain)),
          const SizedBox(height: 8),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '×${item.quantity}',
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
