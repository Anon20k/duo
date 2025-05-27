// lib/services/quiz_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/level_model.dart';

class QuizService {
  /// Carga un JSON de un nivel por nombre de archivo.
  static Future<Nivel> loadNivel(int capitulo, String nombreNivel) async {
    final path =
        'assets/data/capitulo${capitulo.toString().padLeft(2, '0')}/$nombreNivel.json';
    final raw = await rootBundle.loadString(path);
    return Nivel.fromJson(json.decode(raw));
  }
}
