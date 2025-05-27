// lib/widgets/custom_bottom_bar.dart
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  /// Índice de la pestaña actualmente activa (0..4)
  final int currentIndex;

  /// Llamado cuando el usuario pulsa un icono, recibe el índice (0..4)
  final ValueChanged<int> onTap;

  const CustomBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Colores base
    const backgroundColor = Color(0xFF15082F);
    const borderColor = Color.fromARGB(255, 77, 68, 68);

    // Colores neón para la sombra
    const glow1 = Color(0xFF8142FF);
    const glow2 = Color(0xFF5E18BF);

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(color: borderColor, width: 4),
          left: BorderSide(color: borderColor, width: 4),
          right: BorderSide(color: borderColor, width: 4),
          bottom: BorderSide.none,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            // neón más intenso
            color: glow1.withValues(alpha: 102),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, -4),
          ),
          BoxShadow(
            // neón secundario
            color: glow2.withValues(alpha: 76),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildItem(0, 'assets/icons/Notificaciones.png'),
            _buildItem(1, 'assets/icons/Inicio.png'),
            _buildItem(2, 'assets/icons/Recompensas.png'),
            _buildItem(3, 'assets/icons/Estadisticas.png'),
            _buildItem(4, 'assets/icons/perfil.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index, String assetPath) {
    final active = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow:
              active
                  ? [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 100),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ]
                  : null,
        ),
        child: Image.asset(
          assetPath,
          width: 48,
          height: 48,
          // Icono brillante si activo, semitransparente si no
          color: active ? Colors.white : Colors.white54,
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
    );
  }
}
