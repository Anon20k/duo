// lib/screens/panel_niveles_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';
import '../models/level_model.dart';
import '../services/quiz_service.dart';

/// Modelo local para agrupar capítulos.
class Chapter {
  final String title;
  final List<Nivel> levels;
  Chapter({required this.title, required this.levels});
}

class PanelNivelesScreen extends StatefulWidget {
  const PanelNivelesScreen({super.key});

  @override
  State<PanelNivelesScreen> createState() => _PanelNivelesScreenState();
}

class _PanelNivelesScreenState extends State<PanelNivelesScreen> {
  late Future<List<Chapter>> _chaptersFuture;

  @override
  void initState() {
    super.initState();
    _chaptersFuture = _loadAllChapters();
  }

  Future<List<Chapter>> _loadAllChapters() async {
    final nivel1 = await QuizService.loadNivel(1, 'nivel_sumas_resta');
    final nivel2 = await QuizService.loadNivel(2, 'nivel_tablas_multiplicar');

    return [
      Chapter(title: 'Capítulo 1: Conceptos Básicos', levels: [nivel1]),
      Chapter(title: 'Capítulo 2: Tablas de Multiplicar', levels: [nivel2]),
    ];
  }

  /// Carga el conteo de errores para una sección dada.
  Future<int> _loadErrorCount(
    int capIndex,
    Nivel nivel,
    Seccion seccion,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'errors_${capIndex}_${nivel.nivel}_${seccion.seccion}';
    return prefs.getInt(key) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Niveles por Capítulo')),
      body: FutureBuilder<List<Chapter>>(
        future: _chaptersFuture,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(
              child: Text(
                'Error cargando capítulos:\n${snap.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          final chapters = snap.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: chapters.length,
            itemBuilder: (context, ci) {
              final chapter = chapters[ci];
              return ExpansionTile(
                title: Text(
                  chapter.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children:
                    chapter.levels.map((nivel) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: ExpansionTile(
                          title: Text(
                            nivel.nivel,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          children:
                              nivel.secciones.map((seccion) {
                                // calcular total de preguntas
                                final totalPreguntas = seccion.etapas.fold<int>(
                                  0,
                                  (sum, e) => sum + e.preguntas.length,
                                );
                                // para cada sección, mostramos primero un progreso simulado
                                final completion =
                                    totalPreguntas == 0
                                        ? 0.0
                                        : 0.7; // Aquí devuélvelo real si lo guardas

                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Barra de progreso de la sección
                                      Text(
                                        seccion.seccion,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: LinearProgressIndicator(
                                          value: completion,
                                          minHeight: 12,
                                          backgroundColor: Colors.grey[300],
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                Color
                                              >(Colors.green),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      // Desplegable con errores y totales
                                      FutureBuilder<int>(
                                        future: _loadErrorCount(
                                          ci,
                                          nivel,
                                          seccion,
                                        ),
                                        builder: (ctx, errSnap) {
                                          final errores = errSnap.data ?? 0;
                                          final exitos =
                                              totalPreguntas - errores;
                                          final pctExito =
                                              totalPreguntas == 0
                                                  ? 0
                                                  : ((exitos / totalPreguntas) *
                                                          100)
                                                      .round();
                                          final pctFracaso = 100 - pctExito;
                                          return ExpansionTile(
                                            title: const Text('Detalles'),
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  'Errores: $errores',
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'Preguntas totales: $totalPreguntas',
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'Éxito: $pctExito%',
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'Fracaso: $pctFracaso%',
                                                ),
                                              ),
                                              ListTile(
                                                trailing: const Icon(
                                                  Icons.play_arrow,
                                                ),
                                                title: const Text('Entrenar'),
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Routes.entrenamiento,
                                                    arguments: seccion,
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      );
                    }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
