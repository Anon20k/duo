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
                children: [
                  for (final nivel in chapter.levels)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ExpansionTile(
                        title: Text(
                          nivel.nivel,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: [
                          for (final seccion in nivel.secciones)
                            FutureBuilder<int>(
                              future: _loadErrorCount(ci, nivel, seccion),
                              builder: (ctx, errSnap) {
                                final errores = errSnap.data ?? 0;
                                final totalPreguntas = seccion.etapas.fold<int>(
                                  0,
                                  (sum, e) => sum + e.preguntas.length,
                                );
                                final exitos = totalPreguntas - errores;
                                final pctExito =
                                    totalPreguntas == 0
                                        ? 0
                                        : ((exitos / totalPreguntas) * 100)
                                            .round();
                                return InkWell(
                                  onTap:
                                      () => Navigator.pushNamed(
                                        context,
                                        Routes.entrenamiento,
                                        arguments: seccion,
                                      ),
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 8,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        // Título y barra
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                seccion.seccion,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                child: LinearProgressIndicator(
                                                  value:
                                                      totalPreguntas == 0
                                                          ? 0
                                                          : exitos /
                                                              totalPreguntas,
                                                  minHeight: 8,
                                                  backgroundColor:
                                                      Colors.white24,
                                                  valueColor:
                                                      const AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.green),
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                '$exitos / $totalPreguntas  •  $pctExito%',
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Icono Play
                                        const SizedBox(width: 12),
                                        Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.lightBlueAccent,
                                          size: 36,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
