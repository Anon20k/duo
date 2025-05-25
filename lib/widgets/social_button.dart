// lib/widgets/social_button.dart
import 'package:flutter/material.dart';

/// Botón sencillo para mostrar íconos de redes sociales (Google, Facebook, Apple).
class SocialButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onTap;

  const SocialButton({super.key, required this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(iconPath, fit: BoxFit.contain),
      ),
    );
  }
}
