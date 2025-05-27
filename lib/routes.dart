// lib/routes.dart
import 'package:flutter/material.dart';

import 'screens/responsive_login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/home_landing_screen.dart';
import 'screens/panel_niveles_screen.dart';
import 'screens/entrenamiento_screen.dart';
import 'screens/area_estudio_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/rewards_screen.dart';
import 'screens/statistics_screen.dart';

import 'models/level_model.dart';

class Routes {
  static const login = '/';
  static const home = '/home';
  static const landing = '/landing';
  static const panelNiveles = '/panelNiveles';
  static const entrenamiento = '/entrenamiento';
  static const areaEstudio = '/areaEstudio';
  static const profile = '/profile';
  static const notifications = '/notifications';
  static const rewards = '/rewards';
  static const statistics = '/statistics';
}

final Map<String, WidgetBuilder> routes = {
  Routes.login: (_) => const ResponsiveLoginScreen(),
  Routes.home: (_) => const HomeScreen(),
  Routes.landing: (_) => const HomeLandingScreen(),
  Routes.panelNiveles: (_) => const PanelNivelesScreen(),
  Routes.entrenamiento: (ctx) {
    final args = ModalRoute.of(ctx)!.settings.arguments;
    if (args is Seccion) {
      return EntrenamientoScreen(seccion: args);
    }
    throw ArgumentError('La ruta ${Routes.entrenamiento} requiere una Seccion');
  },
  Routes.areaEstudio: (_) => const AreaEstudioScreen(),
  Routes.profile: (_) => const ProfileScreen(),
  Routes.notifications: (_) => const NotificationsScreen(),
  Routes.rewards: (_) => const RewardsScreen(),
  Routes.statistics: (_) => const StatisticsScreen(),
};
