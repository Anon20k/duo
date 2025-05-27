// lib/screens/home_screen.dart
import 'package:flutter/material.dart';

// IMPORTS RELATIVOS con alias para no chocar nombres
import '../widgets/custom_app_bar.dart' as cap;
import '../widgets/custom_bottom_bar.dart' as cbb;

// tus pantallas
import 'notifications_screen.dart';
import 'home_landing_screen.dart';
import 'rewards_screen.dart';
import 'statistics_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  /// pestaña inicial que mostrar:
  /// 0=Notificaciones,1=Landing,2=Recompensas,3=Estadísticas,4=Perfil
  final int initialIndex;
  const HomeScreen({super.key, this.initialIndex = 1});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late int _currentIndex;

  // datos “mock”
  final String _userLevel = 'Nivel 3';
  final int _currentLives = 7;
  final int _maxLives = 10;

  static const List<Widget> _pages = <Widget>[
    NotificationsScreen(),
    HomeLandingScreen(),
    RewardsScreen(),
    StatisticsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTapNav(int idx) {
    setState(() => _currentIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ——> barra superior
      appBar: cap.CustomAppBar(
        currentLives: _currentLives,
        maxLives: _maxLives,
        userLevel: _userLevel,
      ),

      // ——> cuerpo
      body: _pages[_currentIndex],

      // ——> barra inferior
      bottomNavigationBar: cbb.CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: _onTapNav,
      ),
    );
  }
}
