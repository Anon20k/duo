// lib/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Vidas actuales (0..max)
  final int currentLives;

  /// Máximo de vidas (por ejemplo 10)
  final int maxLives;

  /// Nivel del usuario (por ejemplo "Nivel 3")
  final String userLevel;

  const CustomAppBar({
    Key? key,
    required this.currentLives,
    required this.maxLives,
    required this.userLevel,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF8142FF), // Primary 500
            Color(0xFF5E18BF), // Primary 800
          ],
        ),
        boxShadow: [
          BoxShadow(
            // sombra suave debajo de la barra
            color: const Color(0xFF000000).withValues(alpha: 76),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // --- 1) Nivel del usuario ---
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/nivel.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  userLevel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(),

              // --- 2) Icono de rayo ---
              Image.asset(
                'assets/icons/rayo_energia.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 8),

              // --- 3) Barra de vidas (imagen correspondiente al número de vidas) ---
              Image.asset(
                'assets/icons/energy_$currentLives.png',
                width: 120,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),

              // --- 4) Botón de ajustes ---
              IconButton(
                onPressed: () {
                  // TODO: abrir pantalla de ajustes
                },
                icon: Image.asset(
                  'assets/icons/gear.png',
                  width: 32,
                  height: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
