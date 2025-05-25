// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usa el mismo fondo oscuro que el resto
    return Container(
      color: const Color(0xFF15082F),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mi Perfil',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 48, color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Nombre Usuario',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Aquí vendrían tus campos de perfil (ahora placeholders)
            const _ProfileItem(label: 'Email', value: 'usuario@ejemplo.com'),
            const SizedBox(height: 16),
            const _ProfileItem(label: 'Teléfono', value: '+56 600 123 456'),
            const SizedBox(height: 16),
            const _ProfileItem(label: 'Ubicación', value: 'Linares, Chile'),
            const SizedBox(height: 16),
            const _ProfileItem(
              label: 'Biografía',
              value: 'Tu biografía o descripción aquí…',
              multiline: true,
            ),
            const SizedBox(height: 48),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: acción de guardar
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Guardar cambios'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String label;
  final String value;
  final bool multiline;
  const _ProfileItem({
    required this.label,
    required this.value,
    this.multiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
            maxLines: multiline ? null : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
