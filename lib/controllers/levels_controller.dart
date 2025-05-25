// lib/controllers/levels_controller.dart
import 'package:flutter/foundation.dart';

class LevelsController extends ChangeNotifier {
  /// El nivel más alto desbloqueado (por ejemplo, 1 = Nivel 1)
  int _unlockedLevel = 1;

  /// Mapa de niveles completados: nivel → completado?
  final Map<int, bool> _completed = {};

  int get unlockedLevel => _unlockedLevel;

  bool isUnlocked(int nivel) => nivel <= _unlockedLevel;
  bool isCompleted(int nivel) => _completed[nivel] == true;

  /// Llama esto cuando el usuario completa un nivel
  void completeLevel(int nivel) {
    _completed[nivel] = true;
    if (nivel >= _unlockedLevel) {
      _unlockedLevel = nivel + 1;
    }
    notifyListeners();
  }

  /// (Opcional) Resetea todo
  void reset() {
    _unlockedLevel = 1;
    _completed.clear();
    notifyListeners();
  }
}
