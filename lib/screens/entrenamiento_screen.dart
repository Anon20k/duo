// lib/screens/entrenamiento_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/level_model.dart';

/// Pantalla de entrenamiento para una sección específica con opciones múltiples.
class EntrenamientoScreen extends StatefulWidget {
  final Seccion seccion;
  const EntrenamientoScreen({super.key, required this.seccion});

  @override
  State<EntrenamientoScreen> createState() => _EntrenamientoScreenState();
}

class _EntrenamientoScreenState extends State<EntrenamientoScreen> {
  int _etapaIndex = 0;
  int _preguntaIndex = 0;
  bool _answered = false;
  bool _isCorrect = false;
  late List<num> _options;

  @override
  void initState() {
    super.initState();
    _loadOptions();
  }

  void _loadOptions() {
    final pregunta =
        widget.seccion.etapas[_etapaIndex].preguntas[_preguntaIndex];
    _options = List<num>.from(pregunta.opciones)..shuffle();
  }

  /// Incrementa en 1 el contador de errores para esta sección.
  Future<void> _incrementErrorCount() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'errors_${widget.seccion.seccion}';
    final prev = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, prev + 1);
  }

  /// Maneja la selección de opción; guarda error si es incorrecta.
  Future<void> _selectOption(num option) async {
    if (_answered) return;

    final correct =
        widget.seccion.etapas[_etapaIndex].preguntas[_preguntaIndex].respuesta;
    final isCorr = option == correct;

    setState(() {
      _answered = true;
      _isCorrect = isCorr;
    });

    if (!isCorr) {
      // Usuario falló: incrementamos el contador
      await _incrementErrorCount();
    }
  }

  void _next() {
    if (!_answered) return;

    final etapas = widget.seccion.etapas;
    final preguntas = etapas[_etapaIndex].preguntas;
    final esUltimaPregunta = _preguntaIndex >= preguntas.length - 1;
    final esUltimaEtapa = _etapaIndex >= etapas.length - 1;

    if (!esUltimaPregunta) {
      // Avanzar en la misma etapa
      setState(() {
        _preguntaIndex++;
        _answered = false;
        _loadOptions();
      });
    } else {
      // La etapa terminó
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (ctx) => AlertDialog(
              title: const Text('¡Has terminado la etapa!'),
              content: Text(
                esUltimaEtapa
                    ? 'Has completado todas las etapas de esta sección.'
                    : '¿Quieres continuar con la siguiente etapa?',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx) // cierra el diálogo y la pantalla
                      ..pop()
                      ..pop();
                  },
                  child: const Text('Volver al inicio'),
                ),
                if (!esUltimaEtapa)
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(); // cierra el diálogo
                      setState(() {
                        _etapaIndex++;
                        _preguntaIndex = 0;
                        _answered = false;
                        _loadOptions();
                      });
                    },
                    child: const Text('Siguiente etapa'),
                  ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final etapa = widget.seccion.etapas[_etapaIndex];
    final pregunta = etapa.preguntas[_preguntaIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.seccion.seccion} • Etapa ${etapa.etapa}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Pregunta
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blueGrey,
                      child: const Icon(Icons.help, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          pregunta.pregunta,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Feedback de respuesta
            if (_answered)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isCorrect ? Colors.green[100] : Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _isCorrect
                        ? '¡Correcto!'
                        : 'Incorrecto. Respuesta: ${pregunta.respuesta}',
                    style: TextStyle(
                      color: _isCorrect ? Colors.green[800] : Colors.red[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 12),

            // Opciones
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: _options.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (_, i) {
                  final opt = _options[i];
                  Color bg;
                  if (!_answered) {
                    bg = Colors.white;
                  } else if (opt == pregunta.respuesta) {
                    bg = Colors.green[300]!;
                  } else {
                    bg = Colors.red[300]!;
                  }
                  return ElevatedButton(
                    onPressed: () => _selectOption(opt),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      opt.toString(),
                      style: const TextStyle(color: Colors.black87),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Botón Siguiente / Continuar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _answered ? _next : null,
                  child: Text(_answered ? 'Siguiente' : 'Elige una opción'),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
