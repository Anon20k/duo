// lib/material.dart
import 'package:flutter/material.dart';
import 'routes.dart';

/// Pantalla de login responsiva que muestra dos columnas en pantallas anchas
/// y una sola columna en dispositivos más pequeños.
class ResponsiveLoginScreen extends StatelessWidget {
  const ResponsiveLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return _buildWideLayout(context);
        } else {
          return _buildNarrowLayout(context);
        }
      },
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 20,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: const SizedBox(
                      width: 400,
                      child: _LoginFormWidget(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/travel_paradise.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/travel_paradise.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(color: const Color.fromRGBO(0, 0, 0, 0.3)),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 20,
              ),
              child: const SizedBox(
                width: double.infinity,
                child: _LoginFormWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget que representa el formulario de login completo.
class _LoginFormWidget extends StatelessWidget {
  const _LoginFormWidget();

  void _onLogin(BuildContext context) {
    debugPrint('Login button pressed');
    Navigator.pushNamed(context, Routes.panelNiveles);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Begin Your Adventure',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign up with Open account',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SocialButton(iconPath: 'assets/images/google.png'),
            SocialButton(iconPath: 'assets/images/logo-black.png'),
            SocialButton(iconPath: 'assets/images/apple_icon.png'),
          ],
        ),
        const SizedBox(height: 20),
        const Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const TextField(
          decoration: InputDecoration(
            hintText: 'ej. trekker',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const TextField(
          decoration: InputDecoration(
            hintText: 'ej. eltrekker@gmail.com',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: '********',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Checkbox(value: false, onChanged: null),
                Text('Remember me'),
              ],
            ),
            TextButton(onPressed: null, child: const Text('Forgot Password?')),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _onLogin(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Let's Start", style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}

/// Botón sencillo para mostrar íconos de redes sociales.
class SocialButton extends StatelessWidget {
  final String iconPath;

  const SocialButton({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(iconPath, fit: BoxFit.contain),
      ),
    );
  }
}
