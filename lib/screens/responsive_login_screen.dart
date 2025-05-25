// lib/screens/responsive_login_screen.dart
import 'package:flutter/material.dart';
import '../routes.dart';

/// Pantalla de login responsiva que muestra dos columnas en pantallas anchas
/// y una sola columna en dispositivos móviles.
class ResponsiveLoginScreen extends StatelessWidget {
  const ResponsiveLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15082F),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          if (isWide) {
            // Desktop: formulario a la izquierda, logo a la derecha
            return Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: _LoginCard(
                        onSubmit: () {
                          Navigator.pushReplacementNamed(context, Routes.home);
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Image.asset(
                        'assets/images/gamalytix_logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Móvil: logo arriba, formulario abajo
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/gamalytix_logo.png',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  _LoginCard(
                    onSubmit: () {
                      Navigator.pushReplacementNamed(context, Routes.home);
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _LoginCard extends StatefulWidget {
  final VoidCallback onSubmit;
  const _LoginCard({required this.onSubmit});

  @override
  State<_LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<_LoginCard> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  /// Controla si la contraseña está oculta o visible.
  bool _obscurePass = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F0D3A),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título
          Text(
            'Iniciar sesión',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 24),

          // Email
          const Text(
            'Correo electrónico',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _emailCtrl,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white24,
              hintText: 'tú@correo.com',
              hintStyle: const TextStyle(color: Colors.white54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),

          // Contraseña
          const Text('Contraseña', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          TextField(
            controller: _passCtrl,
            obscureText: _obscurePass,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white24,
              hintText: '********',
              hintStyle: const TextStyle(color: Colors.white54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePass ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePass = !_obscurePass;
                  });
                },
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 24),

          // Botón rojo de login
          ElevatedButton(
            onPressed: widget.onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE23E3E),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Iniciar sesión'),
          ),
          const SizedBox(height: 24),

          // Divider con texto
          Row(
            children: <Widget>[
              const Expanded(
                child: Divider(color: Colors.white54, thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'o continúa con',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              const Expanded(
                child: Divider(color: Colors.white54, thickness: 1),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Botones sociales
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Apple login
                },
                child: Image.asset(
                  'assets/images/logo-black.png',
                  width: 48,
                  height: 48,
                ),
              ),
              const SizedBox(width: 24),
              GestureDetector(
                onTap: () {
                  // Google login
                },
                child: Image.asset(
                  'assets/images/google.png',
                  width: 48,
                  height: 48,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
